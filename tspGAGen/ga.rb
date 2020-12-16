#!/usr/bin/env ruby
require "./tsp.rb"
require "./seleccion.rb"
require "./crossover.rb"
require "./mutation.rb"
require "./replacement.rb"
class GA
  attr_accessor :tabla_cost, :max_iteracion
  def initialize(max_iteracion=0,tabla_cost=[[]])
    @max_iteracion=max_iteracion
    @tabla_cost=tabla_cost
    @tsp=TSP.new(@tabla_cost)
  end

  def gen_sol()
    array=[]
    @tabla_cost.length.times{|i|array.push(i)}
    array.length.times{|j|
      array.length.times{|i|
        p1=rand(array.length)
        p2=rand(array.length)
        s=array[p1]
        array[p1]=array[p2]
        array[p2]=s
      }
    }
    array
  end

  def algoritmo(poblacion=0)
    arr_sol=[]
    thread=[]

    iter=0
    arr_cost=[]
    mejor_costo=(2**10000)
    str_solucion=""
    while iter<@max_iteracion
      thread.clear()
      arr_cost.clear()
      arr_sol.clear()
      # Genera un nuevo conjunto de soluciones
      poblacion.times{|i|
        thread<<Thread.new{arr_sol.push(gen_sol)}
      }
      thread.each{|i|i.join}
      arr_sol.each_with_index{|i,j|
        arr_cost.push(@tsp.calculate_cost(i))
        #puts "Solucion #{j}\t#{i.to_s}\nCamino:\n#{@tsp.marca_trayecto(i)}"+
        #  "\n\tCosto: #{arr_cost[-1]}"
      }
      if rand()<0.5
        s=Seleccion.new(arr_sol)
        s.table_cost()
        arrp=s.nam
        p1=arrp[0]
        p2=arrp[1]
        #puts "Seleccion por NAM cuyos valores tengan una distancia grande\n"+
        #      "\tPadre 1 index: #{p1}\tPadre 2 index: #{p2}\n"+
        #      "\tPadre 1: #{arr_sol[p1]}\tPadre 2: #{arr_sol[p2]}"
        c=Crossover.new(arr_sol[p1],arr_sol[p2])
        # Genera una ventana aleatoria para la seleccion de casillas
        c.order_crossover(rand(1..arr_sol[p1].length))
        c1=c.child1
        c2=c.child2
        #puts "\tHijo 1: #{c1.to_s}\tHijo 2: #{c2.to_s}"
        m=Mutation.new(c1)
        m.mut_ord(0.05)
        c1=m.array
        m.array=c2
        m.mut_ord(0.05)
        c2=m.array
        #puts "\tHM1: #{c1.to_s}\tHM2: #{c2.to_s}"
        ch1=@tsp.calculate_cost(c1)
        ch2=@tsp.calculate_cost(c2)
        fp1=@tsp.calculate_cost(arr_sol[p1])
        fp2=@tsp.calculate_cost(arr_sol[p2])
        r=Replacement.new(arr_sol[p1],arr_sol[p2],c1,c2)
        string=r.crowding(1)
        #puts string.to_s
        if string.include?(:p1c1) && fp1>=ch1
          arr_sol[p1]=c1
          arr_cost[p1]=ch1
        elsif string.include?(:p1c2) && fp1>=ch2
          arr_sol[p1]=c2
          arr_cost[p1]=ch2
        elsif string.include?(:p1p2) && fp1>=fp2
          arr_sol[p1]=arr_sol[p2]
          arr_sol[p2]=c1
          arr_cost[p1]=fp2
          arr_cost[p2]=ch1
        end
        if string.include?(:p2c1) && fp2>=ch1
          arr_sol[p2]=c1
          arr_cost[p2]=ch1
        elsif string.include?(:p2c2) && fp2>=ch2
          arr_sol[p2]=c2
          arr_cost[p2]=ch2
        end
      end
      # Busca la mejor solucion de la generacion
      arr_sol.each_with_index{|i,j|
        if @tsp.calculate_cost(i)<=mejor_costo
          mejor_costo=@tsp.calculate_cost(i)
          str_solucion="Mejor solucion en generacion #{iter} con indice #{j}\n"+
            "Camino:\n#{@tsp.marca_trayecto(i)}\nY costo: #{mejor_costo}"
        end
      }
      iter+=1
    end
    str_solucion
  end
end




#tabla=[[10000000000000,4,5,6,7],[6,10000000000000,3,5,4],
#      [3,2,10000000000000,3,2],[1,4,5,10000000000000,5],[5,6,3,2,10000000000000]]
#ga=GA.new(100,tabla)
#puts ga.algoritmo(10)
#tsp=TSP.new(tabla)
#puts tsp.calculate_cost([0,1,2])
#puts tsp.marca_trayecto([0,1,2])
#puts tsp.calculate_cost([1,2,0])
#puts tsp.marca_trayecto([1,2,0])
#puts tsp.calculate_cost([2,0,1])
#puts tsp.marca_trayecto([2,0,1])
