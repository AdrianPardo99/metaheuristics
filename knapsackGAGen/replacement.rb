#!/usr/bin/env ruby
class Replacement
  attr_accessor :parent1,:parent2,:child1,:child2
  def initialize(parent1=[],parent2=[],child1=[],child2=[])
    @parent1=parent1
    @parent2=parent2
    @child1=child1
    @child2=child2
  end

  def elitism(minmax=0)
    """
      En este en el mejor de los casos es bueno que los arreglos sean los
      valores evaluados de cada uno de los padres o que al menos se pueda
      obtener el valor de la evaluacion fitness de cada elemento de los arreglos
    """
    #puts "Remplazo elitista mediante las funciones fitness"
    hash_min={}
    hash_min[:p1]=@parent1[0]
    hash_min[:p2]=@parent2[0]
    hash_min[:c1]=@child1[0]
    hash_min[:c2]=@child2[0]
    hash_min=hash_min.sort_by {|k, v| -v}
    arr_f1=[]
    arr_f2=[]
    if minmax==0
      #puts "Minimizacion"
      arr_f1=hash_min[-1]
      arr_f2=hash_min[-2]
    else
      #puts "Maximizacion"
      arr_f1=hash_min[0]
      arr_f2=hash_min[1]
    end
    #puts "Seleccionados #{arr_f1.to_s}, #{arr_f2.to_s}"
    return [arr_f1[0],arr_f2[0]]
  end

end
