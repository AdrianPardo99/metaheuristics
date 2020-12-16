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

  def sum_fitness()
    sum=0
    @array.length.times{|i|
      sum+=array[i]
    }
    sum
  end

  def ruleta()
    """
      @array  ->  en esta cada elemento tiene la misma probabilidad de ser seleccionados
    """
    pi=[]
    piece=1.0/@array.length
    #puts "Tamanio de la separacion de las piezas: #{sprintf("%.4f",piece)}"
    #puts "Intervalos de la ruleta"
    @array.length.times{|i|
      pi.push(piece)
      #puts "\t\t[#{sprintf("%.4f",piece*i)},#{sprintf("%.4f",piece*(i+1))}]"
    }
    arrow_init=rand(0.0..1.0)
    #puts "Elemento seleccionado #{arrow_init}"

    sum_acumulada=0
    pi.length.times{|j|
      sum_acumulada+=pi[j]
      if sum_acumulada>=arrow_init
        return j
      end
    }
  end

end
