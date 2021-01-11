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
    #puts "Permutacion de indices\t#{permutacion.to_s}"
    permutacion
  end

  def torneo(max_min=0)
    """
      @array  ->  son los valores de fitness de distintos valores a
                  ser evaluados por lo que en esta seccion compiten
    """
    k=rand(2..@array.length)
    #puts "Valor de cuantas iteraciones #{k}"
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
    @table={}
    mejor.each{|i|
      if table.key?(i)
        table[i]+=1
      else
        table[i]=1
      end
    }
    @table=@table.sort_by {|k, v| -v}
    @table[0][0]
  end

  def proporcional()
    """
      @array  ->  en esta intervienen los fitness evaluados para ver cuales
                  elementos son considerados para su seleccion
                  (por la forma que tienen) es mejor que sea para una
                  maximizacion
    """
    sum_t=sum_fitness()
    pi=[]
    @array.length.times{|i|
      pi.push(@array[i].to_f/sum_t)
    }
    #print "Parte proporcional de cada pi ["
    #pi.each{|i|
    #  print " #{sprintf("%.4f",i)} "
    #}
    #puts "]"
    #puts "Intervalos de la seleccion proporcional:"
    #sum=0
    #pi.each{|i|
    #  puts "\t\t[#{sprintf("%.4f",sum)} a #{sprintf("%.4f",sum+i)}]"
    #  sum+=i
    #}
    arrow_init=rand(0.0..1.0)
    #puts "Elemento seleccionado #{arrow_init}"
    mejor_respuesta=[]
    sum_acumulada=0
    pi.length.times{|j|
      sum_acumulada+=pi[j]
      if sum_acumulada>=arrow_init
        return j
      end
    }
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
    puts "Arreglo:\n\t#{@array.to_s}"

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
