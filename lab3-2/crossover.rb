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

end

array1=[0,1,1,0,1]
array2=[1,0,2,0,0]
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
