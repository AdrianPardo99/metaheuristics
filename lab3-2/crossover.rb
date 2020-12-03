#!/usr/bin/env ruby

class Crossover
  attr_accessor :parent1,:parent2,:child1,:child2
  def initialize(parent1=[],parent2=[])
    """
      @parent1 y @parent2 ->  es un arreglo con los datos que vamos a utilizar
                              para la cruza de sus datos
    """
    @parent1=parent1
    @parent2=parent2
    @child1=[]
    @child2=[]
  end

  def gen_permutacion()
    permutacion=[]
    (@parent1.length).times{|i|
      permutacion.push(i)
    }

    (@parent1.length).times{
      cambia=rand(@parent1.length-1)
      cambia1=rand(@parent1.length-1)
      val0=permutacion[cambia]
      val1=permutacion[cambia1]
      permutacion[cambia1]=val0
      permutacion[cambia]=val1
    }
    permutacion
  end

  def uniforme()
    """
      array_p ->  Es el vector que contiene los valores probabilisticos de
                  realizacion de cruza o no de los datos, contiene valores
                  aleatorios de [0,1]
    """
    array_p=[]
    @child1=[]
    @child2=[]
    @parent1.each{|i|
      array_p.push(rand())
    }
    print "Probabilidades: ["
    array_p.each{|i|
      print " #{sprintf("%.5f",i)} "
    }
    puts "]"
    for i in 0..(@parent1.length-1)
      #puts "[#{i}] Parent 1: #{@parent1[i]}, Parent 2: "+
      #  "#{@parent2[i]}, probability: #{sprintf("%.5f",array_p[i])}"
      if array_p[i]>=0.5
        @child1.push(@parent2[i])
        @child2.push(@parent1[i])
      else
        @child1.push(@parent1[i])
        @child2.push(@parent2[i])
      end
    end
  end

  def aritmetic()
    """
      alpha ->  Es un valor aleatorio entre [0,1] que va a multiplicar a los
                valores reales de sus padre y asi realiza la cruza
    """
    @child1=[]
    @child2=[]
    alpha=0
    for i in 0..(@parent1.length-1)
      alpha=rand()
      child1.push(alpha*@parent1[i]+(1-alpha)*@parent2[i])
      child2.push(alpha*@parent2[i]+(1-alpha)*@parent1[i])
    end
  end

  def single_crossover()
    """
      k ->  Es un valor entero el cual contendra el valor donde se realizara
            el corte para la cruza de datos
    """
    @child1=[]
    @child2=[]
    k=rand(@parent1.length)
    puts "Corte en indice #{k}"
    @parent1.length.times{|i|
      if i>=k
        @child1.push(@parent2[i])
        @child2.push(@parent1[i])
      else
        @child1.push(@parent1[i])
        @child2.push(@parent2[i])
      end
    }
  end

  def n_point_crossover(k=2)
    arr=gen_permutacion
    arr_g=[]
    k.times{|v|arr_g.push(arr[v])}
    arr_g=arr_g.sort
    k1=0
    @child1=[]
    @child2=[]
    @parent1.length.times{|i|
      if arr_g[k1]==i
        k1+=1
      end
      if k1%2==0
        @child1.push(@parent1[i])
        @child2.push(@parent2[i])
      else
        @child1.push(@parent2[i])
        @child2.push(@parent1[i])
      end
    }
    puts "Cortes en #{arr_g.to_s}"
  end

  def order_crossover(t_ventana=1)
    """
      ventana ->  Es el indice donde iniciara a realizar la ventana (indice)
                  y este acompletara los datos con lo que se obtenga tanto
                  de la la consulta de datos en los hijos como del contenido de
                  los padres
    """
    ventana=rand((@parent1.length-t_ventana)).to_i
    puts "\tCruza por orden Ventana en #{ventana}\n\tTamanio array "+
      "#{@parent1.length}, con ventana de tamanio #{t_ventana}"
    @child1=[]
    @child2=[]
    t=0
    @parent1.length.times{|i|
      if i>=ventana && t<t_ventana
        @child1.push(@parent1[i])
        @child2.push(@parent2[i])
        t+=1
      else
        @child1.push(nil)
        @child2.push(nil)
      end
    }
    t=0
    t1=0
    t_ventana.times{|i|
      @parent1.length.times{|i|
        if @child1[i].nil?
          if !@child1.include?(@child2[ventana+t]) && !@child2[ventana+t].nil?
            @child1[i]=@child2[ventana+t]
            t+=1
          end
        end
        if @child2[i].nil?
          if !@child2.include?(@child1[ventana+t1]) && !@child1[ventana+t1].nil?
            @child2[i]=@child1[ventana+t1]
            t1+=1
          end
        end
      }
    }
    @parent1.length.times{|i|
      @parent1.length.times{|j|
        if @child1[i].nil? && !@child1.include?(@parent2[j])
          @child1[i]=@parent2[j]
          break
        end
      }
      @parent2.length.times{|j|
        if @child2[i].nil? && !@child2.include?(@parent1[j])
          @child2[i]=@parent1[j]
          break
        end
      }
    }

  end

end

array1=[0,1,1,3,1]
array2=[1,0,2,4,0]
c=Crossover.new(array1,array2)
puts "Cruza uniforme"
c.uniforme()
puts "Padre 1:\t#{array1.to_s}\nPadre 2:\t#{array2.to_s}\n\n"+
    "Hijo c1:\t#{c.child1.to_s}\nHijo c2:\t#{c.child2.to_s}\n\n"+
    "Metodo aritmetico"
c.aritmetic
puts "Padre 1:\t#{array1.to_s}\nPadre 2:\t#{array2.to_s}\n\n"+
    "Hijo c1:\t#{c.child1.to_s}\nHijo c2:\t#{c.child2.to_s}\n\n"+
    "Metodo single crossover"
c.single_crossover()
puts "Padre 1:\t#{array1.to_s}\nPadre 2:\t#{array2.to_s}\n\n"+
    "Hijo c1:\t#{c.child1.to_s}\nHijo c2:\t#{c.child2.to_s}"
array1=[0,1,2,3,4,5]
array2=[5,1,3,2,4,0]
c.parent1=array1
c.parent2=array2
c.order_crossover(2)
puts "Padre 1:\t#{array1.to_s}\nPadre 2:\t#{array2.to_s}\n\n"+
    "Hijo c1:\t#{c.child1.to_s}\nHijo c2:\t#{c.child2.to_s}"
