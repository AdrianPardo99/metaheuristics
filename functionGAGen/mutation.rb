#!/usr/bin/env ruby
class Mutation
  attr_accessor :array
  def initialize(array=[])
    @array=array
  end

  def mut_real_by_index(index=0,min=0,max=0)
    """
      Esta funcion muta de forma aleatoria un elemento real de min-max
    """
    puts "Indice a modificar #{index}"
    @array[index]=rand(min..max)
  end

  def mut_real(min=0,max=0,probability=0.0001)
    """
      Esta funcion muta de forma aleatoria todos los elementos reales
        de min-max
    """
    @array.length.times{|i|
      @array[i]=(rand<probability)?(rand(min..max)):(@array[i])
    }
  end

  def mut_bin_by_index(index=0)
    """
      Esta funcion muta de forma aleatoria un elemento binario
    """
    puts "Indice a modificar #{index}"
    @array[index]=(rand()>0.5)?((@array[index]-1).abs):(@array[index])
  end

  def mut_bin(probability=0.0001)
    """
      Esta funcion muta de forma aleatoria todos los elementos binarios
    """
    @array.length.times{|i|
      @array[i]=(rand()<probability)?((@array[i]-1).abs):(@array[i])
    }
  end

  def mut_ord_by_index(index=0)
    """
      Esta funcion permuta un elemento del array con un indice
        y con el otro elemento de forma aleatoria
    """
    print "Indice a modificar #{index}\n#{@array.to_s}\t"
    sec=rand(@array.length)
    v=@array[index]
    @array[index]=@array[sec]
    @array[sec]=v
    puts "Permuta #{index}<->#{sec}\t#{@array.to_s}"
  end

  def mut_ord()
    """
      Esta funcion permuta todos los elementos del array de forma aleatoria
    """
    @array.length.times{|i|
      c=rand(@array.length)
      d=rand(@array.length)
      print "#{@array.to_s}\t"
      v=@array[c]
      @array[c]=@array[d]
      @array[d]=v
      puts "Permuta #{c}<->#{d}\t #{@array.to_s}"
    }
  end

end
