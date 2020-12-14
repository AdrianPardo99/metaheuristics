#!/usr/bin/env ruby

class Seleccion
  attr_accessor :array,:table
  def initialize(array=[])
    """
      @array  ->  es el arreglo el cual contiene las evaluaciones de la funcion
                  a optimizar o es el arreglo de elementos para evaluar
    """
    @array=array
    @table={}
  end

  def table_cost()
    # Modificacion de llenar matriz de distancia por costo computacional
    for i in 0..(@array.length-1)
      for j in (i+1)..(@array.length-1)
        arreglo1=@array[i]
        arreglo2=@array[j]
        sum=0
        l=0
        for l in 0..(arreglo1.length-1)
          sum+=(arreglo2[l]-arreglo1[l]).abs
        end
        @table["#{i},#{j}"]=sum
      end
    end
  end

  def nam()
    """
      @array  ->  es el arreglo de valores de cada solucion por lo
                  que es necesario sacar las distancias de cada uno para
                  entregar dos valores cuya distancia sea la mejor
    """
    #puts "Arreglo:\n\t#{@array.to_s}"

    valores_d=[]
    #puts "Tabla de distancias\n\t#{@table.to_s}"
    @table=@table.sort_by{|k,v|-v}
    @table[0][0].split(",",-1).map(&:to_i)

  end

end
