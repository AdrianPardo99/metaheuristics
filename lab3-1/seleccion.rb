#!/usr/bin/env ruby

class Seleccion
  attr_accessor :array
  def initialize(array=[])
    """
      @array  ->  es el arreglo el cual contiene las evaluaciones de la funcion
                  a optimizar o es el arreglo de elementos para evaluar
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
    puts "Permutacion de indices\t#{permutacion.to_s}"
    permutacion
  end

  def torneo(max_min=0)
    """
      @array  ->  son los valores de fitness de distintos valores a
                  ser evaluados por lo que en esta sección compiten
    """
    k=rand(2..@array.length)
    puts "Valor de cuantas iteraciones #{k}"
    valores=[]
    for i in 0..k-1
      valores.push(gen_permutacion)
    end

    mejor=valores.pop
    valores.each{|val|
      (@array.length-1).times{|i|
        if max_min==0
          if @array[mejor[i]]>@array[val[i]]
            mejor[i]=val[i]
          end
        else
          if @array[mejor[i]]<@array[val[i]]
            mejor[i]=val[i]
          end
        end
      }
    }
    mejor
  end

  def ruleta()
    """
      @array  ->  en esta intervienen los fitness evaluados para ver cuales
                  elementos son considerados para su selección
                  (por la forma que tienen) es mejor que sea para una
                  maximizacion
    """
    sum_t=sum_fitness()
    pi=[]
    @array.length.times{|i|
      pi.push(@array[i].to_f/sum_t)
    }
    puts "Parte ruleta de cada pi #{pi.to_s}"
    puts "Intervalos de la ruleta: "
    sum=0
    pi.each{|i|
      puts "\t\t[#{sum} a #{sum+i}]"
      sum+=i
    }
    puts ""
    piece=2*Math::PI/sum_fitness
    arrow_init=rand(0.0..1.0)*piece
    puts "Tamanio de la separacion de las flechas: #{piece}"
    puts "Inicio en la ruleta #{arrow_init}"
    mejor_respuesta=[]
    @array.length.times{|i|
      sum_acumulada=0
      pi.length.times{|j|
        sum_acumulada+=pi[j]
        if sum_acumulada>=arrow_init
          mejor_respuesta.push(j)
          break
        end
      }
      arrow_init+=piece
      if arrow_init>1
        arrow_init-=1
      end
    }
    return mejor_respuesta
  end

  def nam()
    """
      @array  ->  es el arreglo de valores de cada solución por lo
                  que es necesario sacar las distancias de cada uno para
                  entregar dos valores cuya distancia sea la mejor
    """
    puts "Arreglo:\n\t#{array.to_s}"
    table={}
    for i in 0..(@array.length-1)
      for j in (i+1)..(@array.length-1)
        arreglo1=@array[i]
        arreglo2=@array[j]
        sum=0
        l=0
        for l in 0..(arreglo1.length-1)
          sum+=(arreglo2[l]-arreglo1[l]).abs
        end
        table["#{i},#{j}"]=sum
      end
    end
    valores_d=[]
    puts "Tabla de distancias\n\t#{table.to_s}"
    for i in 0..(table.length-1)
      for j in (i+1)..(table.length-1)
        valores_d.push(table.values[i]-table.values[j])
      end
    end
    seleccionados=[]
    valores_d.each_with_index{|i,j|
      if i!=1 && i!=-1
        seleccionados.push(table.keys[j].split(",",-1).map(&:to_i))
      end
    }
    seleccionados
  end

end

array_fitness=[2,5,6,1,4,10]
puts "Fitness function\t#{array_fitness.to_s}"
s=Seleccion.new(array_fitness)
mejor_torneo=s.torneo
puts "\nArreglo torneo\t#{mejor_torneo}\n\n"

sus=s.ruleta()
puts "\nMejor por ruleta\t#{sus.to_s}\n\n"
array_fitness=[ [2,5,6,1,4,10], [6,7,1,4,5,6], [10,10,10,10,10,10] ]
s.array=array_fitness
na=s.nam()
puts "Indices seleccionados\t#{na.to_s}"
