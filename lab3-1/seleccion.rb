#!/usr/bin/env ruby

class Seleccion
  attr_accessor :array
  def initialize(array=[])
    """
      @array -> es el arreglo el cual contiene las evaluaciones de la funcion a
                optimizar
    """
    @array=array
  end

  def sum_fitness()
    sum=0
    @array.length.times{|i|
      sum+=array[i]
    }
    sum
  end

  def gen_permutacion()
    permutacion=[]
    (@array.length).times{|i|
      permutacion.push(i)
    }

    (@array.length).times{
      cambia=rand(@array.length-1)
      cambia1=rand(@array.length-1)
      val0=permutacion[cambia]
      val1=permutacion[cambia1]
      permutacion[cambia1]=val0
      permutacion[cambia]=val1
    }
    puts "Permutacion obtenida\t#{permutacion.to_s}"
    permutacion
  end

  def torneo()
    k=rand(@array.length)
    puts "Valor de cuantas iteraciones #{k}"
    valores=[]
    for i in 0..k-1
      valores.push(gen_permutacion)
    end

    mejor=valores.pop
    valores.each{|val|
      (@array.length-1).times{|i|
        if @array[mejor[i]]>@array[val[i]]
          mejor[i]=val[i]
        end
      }
    }
    mejor
  end

  def ruleta()
    sum_t=sum_fitness()
    pi=[]
    @array.length.times{|i|
      pi.push(@array[i].to_f/sum_t)
    }
    puts "Parte ruleta de cada pi #{pi.to_s}"
    piece=2*Math::PI/@array.length
    arrow_init=rand(0.0..1.0)*piece
    puts "Inicio en la ruleta #{arrow_init}"
    sum_acumulada=0
    mejor_respuesta=[]
    pi.length.times{|j|
      sum_acumulada+=pi[j]
      if sum_acumulada>=arrow_init
        return j
      end
    }
  end

  def nam()
    steps=rand(2..(@array.length/rand(2..3)))
    mejor_respuesta=[]
    init=rand(@array.length-1)
    for i in (init..@array.length).step(steps)
      mejor_respuesta.push(i)
    end
    mejor_respuesta
  end


end

array_fitness=[2,5,6,1,4,10]
puts "Fitness function\t#{array_fitness.to_s}"
s=Seleccion.new(array_fitness)
mejor_torneo=s.torneo
puts "\nElementos sel torneo\t#{mejor_torneo}\n\n"

sus=s.ruleta()
puts "\nMejor por ruleta\t#{sus}\n\n"

na=s.nam()
puts "Respuesta por Emparejamiento Inverso\t#{na.to_s}"
