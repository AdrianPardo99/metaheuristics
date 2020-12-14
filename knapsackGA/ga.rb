#!/usr/bin/env ruby
require "./mochila.rb"
require "./seleccion.rb"
require "./crossover.rb"
require "./mutation.rb"
require "./replacement.rb"
class GA
  attr_accessor :peso_max,:max_iteracion
  def initialize(peso_max=0,max_iteracion=0)
    @peso_max=peso_max
    @max_iteracion=max_iteracion
    @mochila=Mochila.new(peso_max)
  end

  def add_elemento(peso=0,beneficio=0)
    @mochila.add_elemento(peso,beneficio)
  end

  def gen_sol()
    array=[]
    @mochila.objetos.length.times{|i|
      array.push(rand()>0.5?1:0)
    }
    array
  end

  def algoritmo(num=0)
    arr_sol=[]
    thread=[]
    num.times{|i|
      # Generacion de soluciones via paralela de modo en que se puede
      #   realizar en menor tiempo el encuentro de soluciones validas
      thread<<Thread.new{
        ban=true
        while ban
          sol=gen_sol()
          #puts "Iteracion #{i}: Solucion generada #{sol.to_s} "+
          #  "peso maximo #{@peso_max} con peso en solucion "+
          #  "#{@mochila.get_peso(sol)}"
          if(@peso_max>=@mochila.get_peso(sol))
            arr_sol.push(sol)
            ban=false
          end
        end
      }
    }
    thread.each{|i|i.join}
    #puts "arreglo #{arr_sol.to_s}"
    iter=0
    while iter<@max_iteracion
      arr_ben=[]
      arr_sol.each_with_index{|i,j|
        arr_ben.push(@mochila.get_beneficio(i))
        #puts "Solucion #{j}: #{i.to_s}\n\tCon peso #{@mochila.get_peso(i)}"+
        #" y beneficio #{@mochila.get_beneficio(i)}"
        #"\n#{@mochila.get_selected_sol(i)}"
      }

      s=Seleccion.new(arr_ben)
      #puts "Seleccion por ruleta \n\tPadre 1: #{}\t"+
      #  "Padre 2: #{}\n"
      index=s.ruleta()
      index2=s.ruleta()
      c=Crossover.new(arr_sol[index],arr_sol[index2])
      c.uniforme()
      hijo1=c.child1
      hijo2=c.child2
      #puts "\tPadre 1: #{arr_sol[index]}\tPadre 2: #{arr_sol[index2]}\n\t"+
      #  "Hijo 1: #{hijo1.to_s}\tHijo 2: #{hijo2.to_s}"
      m=Mutation.new(hijo1)
      m.mut_bin(0.5)
      hijo1=m.array
      m.array=hijo2
      m.mut_bin(0.5)
      hijo2=m.array
      ph1=@mochila.get_peso(hijo1)
      bh1=@mochila.get_beneficio(hijo1)
      ph2=@mochila.get_peso(hijo2)
      bh2=@mochila.get_beneficio(hijo2)
      #puts "\n\tHM1: #{hijo1.to_s}\tHM2: #{hijo2.to_s}\n\tPeso: #{ph1} y "+
      #   "Beneficio: #{bh1} de HM1\n\tPeso: #{ph2} y Beneficio: #{bh2} de HM2"
      r=Replacement.new([@mochila.get_beneficio(arr_sol[index])],
        [@mochila.get_beneficio(arr_sol[index2])],[bh1],[bh2])
      string=r.elitism(1)
      if !string.include?(:p1) || !string.include?(:p2)
        if !string.include?:p1
          if string.include?:p2
            arr_sol[index]=arr_sol[index2]
          elsif string.include?(:c1) && ph1<=@peso_max
            arr_sol[index]=hijo1
          elsif string.include?(:c2) && ph2<=@peso_max
            arr_sol[index]=hijo2
          end
        end
        if !string.include?:p2
          if string.include?:p1
            arr_sol[index2]=arr_sol[index]
          elsif string.include?(:c1) && ph1<=@peso_max
            arr_sol[index2]=hijo1
          elsif string.include?(:c2) && ph2<=@peso_max
            arr_sol[index2]=hijo2
          end
        end
      end
      iter+=1
    end
    str="Objetos de la mochila\n#{@mochila.get_objetos}\n\t"+
      "Maximo peso #{@peso_max}"
    sol=""
    mejor=0
    arr_sol.each_with_index{|i,j|
      if @mochila.get_beneficio(i)>=@mochila.get_beneficio(arr_sol[mejor])
        mejor=j
        sol="Solucion mejor obtenida con indice #{j}: #{i.to_s}\n\t"+
          "Con peso #{@mochila.get_peso(i)}"+
          " y beneficio #{@mochila.get_beneficio(i)}\n"+
          "#{@mochila.get_selected_sol(i)}"
      end
      #"\n#{@mochila.get_selected_sol(i)}"
    }
    str+="\n#{sol}"
  end
end
