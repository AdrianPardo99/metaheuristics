#!/usr/bin/env ruby
class Mutation
  attr_accessor :array
  def initialize(array=[])
    @array=array
  end

  def mut_bin(probability=0.0001)
    """
      Esta funcion muta de forma aleatoria todos los elementos binarios
    """
    @array.length.times{|i|
      @array[i]=(rand()<probability)?((@array[i]-1).abs):(@array[i])
    }
  end

end
