#!/usr/bin/env ruby
class Mutation
  attr_accessor :array
  def initialize(array=[])
    @array=array
  end

  def mut_ord(probability=0.001)
    """
      Esta funcion permuta todos los elementos del array de forma aleatoria
    """
    @array.length.times{|i|
      c=rand(@array.length)
      d=rand(@array.length)
      #print "#{@array.to_s}\t"
      if rand()<probability
        v=@array[c]
        @array[c]=@array[d]
        @array[d]=v
        #puts "Permuta #{c}<->#{d}\t #{@array.to_s}"
      end
    }
  end

end
