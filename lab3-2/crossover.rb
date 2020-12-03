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

  def order_crossover()
    """
      k ->  Es un valor aleatorio para el intercambio de genes de p1
      m ->  Es otro valor aleatorio para el intercambio de genes de p1
      l ->  Like k p2
      n ->  Line m p2
    """
    @child1=[]
    @child2=[]
    k=rand(@parent1.length)
    m=rand(@parent1.length)
    l=rand(@parent2.length)
    n=rand(@parent2.length)
    puts "Valores de intercambio\n\tk<->m\t&\tl<->n\n\t#{k}<->#{m}\t&\t#{l}<->#{n}"
    @parent1.each_with_index{|i,j|
      if j==k
        @child1.push(@parent1[m])
      elsif j==m
        @child1.push(@parent1[k])
      else
        @child1.push(@parent1[j])
      end
      if j==l
        @child2.push(@parent2[n])
      elsif j==n
        @child2.push(@parent2[l])
      else
        @child2.push(@parent2[j])
      end
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

c.order_crossover()
puts "Padre 1:\t#{array1.to_s}\nPadre 2:\t#{array2.to_s}\n\n"+
    "Hijo c1:\t#{c.child1.to_s}\nHijo c2:\t#{c.child2.to_s}"

c.n_point_crossover(3)
puts "Padre 1:\t#{array1.to_s}\nPadre 2:\t#{array2.to_s}\n\n"+
    "Hijo c1:\t#{c.child1.to_s}\nHijo c2:\t#{c.child2.to_s}"
