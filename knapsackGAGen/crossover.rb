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
    #print "Probabilidades: ["
    #array_p.each{|i|
    #  print " #{sprintf("%.5f",i)} "
    #}
    #puts "]"
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

end
