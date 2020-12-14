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

  def order_crossover(t_ventana=1)
    """
      ventana ->  Es el indice donde iniciara a realizar la ventana (indice)
                  y este acompletara los datos con lo que se obtenga tanto
                  de la la consulta de datos en los hijos como del contenido de
                  los padres
    """
    ventana=rand((@parent1.length-t_ventana)).to_i
    #puts "\tCruza por orden Ventana en #{ventana}\n\tTamanio array "+
    #  "#{@parent1.length}, con ventana de tamanio #{t_ventana}"
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
