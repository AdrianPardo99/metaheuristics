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

  def algoritmo(poblacion=0)
    arr_sol=[]
    thread=[]
    #puts "arreglo #{arr_sol.to_s}"
    iter=0
    # Modificar para N evaluaciones y verificar cual es la mejor poblacion
    #  y en que generacion fue generada la mejor evaluacion
    arr_ben=[]
    mejor_finess=-1
    str_solucion=""
    while iter<@max_iteracion
      thread.clear()
      arr_ben.clear()
      arr_sol.clear()
      #  Genera una nueva solucion en cada iteracion
      poblacion.times{|i|
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
      arr_sol.each_with_index{|i,j|
        arr_ben.push(@mochila.get_beneficio(i))
      }
      if rand()<0.5
        s=Seleccion.new(arr_ben)
        #puts "Seleccion por ruleta \n\tPadre 1: #{}\t"+
        #  "Padre 2: #{}\n"
        index=s.ruleta()
        index2=s.ruleta()
        # Verificar si no hay cruza no debe realizar la operacion
        c=Crossover.new(arr_sol[index],arr_sol[index2])
        c.uniforme()
        hijo1=c.child1
        hijo2=c.child2
        #puts "\tPadre 1: #{arr_sol[index]}\tPadre 2: #{arr_sol[index2]}\n\t"+
        #  "Hijo 1: #{hijo1.to_s}\tHijo 2: #{hijo2.to_s}"
        # Si son
        m=Mutation.new(hijo1)
        m.mut_bin(0.05)
        hijo1=m.array
        m.array=hijo2
        m.mut_bin(0.05)
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
              arr_ben[index]=arr_ben[index2]
            elsif string.include?(:c1) && ph1<=@peso_max
              arr_sol[index]=hijo1
              arr_ben[index]=bh1
            elsif string.include?(:c2) && ph2<=@peso_max
              arr_sol[index]=hijo2
              arr_ben[index]=bh2
            end
          end
          if !string.include?:p2
            if string.include?:p1
              arr_sol[index2]=arr_sol[index]
              arr_ben[index2]=arr_ben[index]
            elsif string.include?(:c1) && ph1<=@peso_max
              arr_sol[index2]=hijo1
              arr_ben[index2]=bh1
            elsif string.include?(:c2) && ph2<=@peso_max
              arr_sol[index2]=hijo2
              arr_ben[index2]=bh2
            end
          end
        end
      end
      #  Busca la mejor solucion de la generacion
      arr_sol.each_with_index{|i,j|
        if@mochila.get_beneficio(i)>=mejor_finess
          mejor_finess=@mochila.get_beneficio(i)
          str_solucion="Solucion en generacion #{iter} con indice #{j}:\t#{i.to_s}\n\t"+
            "Con peso: #{@mochila.get_peso(i)} y beneficio #{mejor_finess}\n"+
            "#{@mochila.get_selected_sol(i)}"
        end
      }
      iter+=1
    end
    str="Objetos de la mochila\n#{@mochila.get_objetos}\n\t"+
      "Maximo peso #{@peso_max}"
    str+="\n#{str_solucion}"
  end
end
