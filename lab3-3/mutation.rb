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

  def mut_real(min=0,max=0)
    """
      Esta funcion muta de forma aleatoria todos los elementos reales
        de min-max
    """
    @array.length.times{|i|
      @array[i]=rand(min..max)
    }
  end

  def mut_bin_by_index(index=0)
    """
      Esta funcion muta de forma aleatoria un elemento binario
    """
    puts "Indice a modificar #{index}"
    @array[index]=(rand()<0.5)?(1):(0)
  end

  def mut_bin()
    """
      Esta funcion muta de forma aleatoria todos los elementos binarios
    """
    @array.length.times{|i|
      @array[i]=(rand()>0.5)?(1):(0)
    }
  end

  def mut_ord_by_index(index=0)
    """
      Esta funcion permuta un elemento del array con un indice
        y con el otro elemento de forma aleatoria
    """
    sec=rand(@array.length)
    v=@array[index]
    @array[index]=@array[sec]
    @array[sec]=v
  end

  def mut_ord()
    """
      Esta funcion permuta todos los elementos del array de forma aleatoria
    """
    @array.length.times{|i|
      c=rand(@array.length)
      d=rand(@array.length)
      v=@array[c]
      @array[c]=@array[d]
      @array[d]=v
    }
  end

end
arr_real=[4.5,10.5,2.4,4.3,0]
m=Mutation.new(arr_real)
puts "Arreglo Real: #{arr_real.to_s}\nMutacion real por indice"
m.mut_real_by_index(2,-10.0,10.0)
arr_real=m.array
puts "Arreglo Real mutado: #{arr_real.to_s}\n\nMutacion real todos"
m.mut_real(-10.0,10.0)
arr_real=m.array
puts "Arreglo Real mutado: #{arr_real.to_s}\n"
arr_bin=[0,1,0,1,1,0,0]
m.array=arr_bin
puts "\nArreglo binario #{arr_bin.to_s}\nMutacion bin por indice"
m.mut_bin_by_index(3)
arr_bin=m.array
puts "Arreglo mutado: #{arr_bin.to_s}\n\nMutacion bin todo"
m.mut_bin
arr_bin=m.array
puts "Arreglo mutado: #{arr_bin.to_s}\n"
arr_ord=[0,1,2,3,4,5]
m.array=arr_ord
puts "\nArreglo orden #{arr_ord}\nMutacion orden por indice"
m.mut_ord_by_index(3)
arr_ord=m.array
puts "Arreglo mutado: #{arr_ord}\n\nMutacion orden todos"
m.mut_ord
arr_ord=m.array
puts "Arreglo mutado: #{arr_ord}"
