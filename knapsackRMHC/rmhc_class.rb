#!/usr/bin/env ruby
require "./mochila.rb"
require "./heuristica.rb"
class Rmhc_class
  attr_accessor :mochila_new,:e,:mochila_old
  def initialize(mochila_old=Mochila.new,e=0)
    @mochila_old=mochila_old
    @mochila_new=Mochila.new
    @mochila_new.max_peso=@mochila_old.max_peso
    @e=e
    @evolution=Heuristica.new
  end

  def swap()
    @mochila_old=@mochila_new
    @mochila_new=Mochila.new
    @mochila_new.max_peso=@mochila_old.max_peso
    @mochila_old.objetos.each{|i|
      @mochila_new.add_object([i.peso,i.beneficio])
    }
  end
  def new_object(arr)
    @mochila_old.add_object(arr)
    @mochila_new.add_object(arr)
  end

  def object_in_old_knapsack(index)
    @mochila_old.in_knapsack[index]=true
  end

  def object_in_new_knapsack(index)
    @mochila_new.in_knapsack[index]=true
  end

  def print_maximum()
    puts "Mochila peso maximo: #{@mochila_old.max_peso}"
  end
  def show_old_all()
    @mochila_old.show_all_objects
  end

  def show_new_all()
    @mochila_new.show_all_objects
  end

  def show_solucion(mochila,name)
    puts "\nSolucion #{name}"
    mochila.show_in_knapsack
  end
  def show_solucion_general(mochila)
    puts "Peso total de la solución: #{mochila.get_peso_in_knapsack}\n"+
    "Con beneficio total: #{mochila.get_beneficio_in_knapsack}"
  end

  def print_mochila_old_desc()
    print_maximum
    show_old_all
    show_solucion(@mochila_old,"vieja")
    show_solucion_general(@mochila_old)
  end

  def print_mochila_new_desc()
    print_maximum
    show_solucion(@mochila_new,"nueva")
    show_solucion_general(@mochila_new)
  end

  def algorithm()
    j=0
    while j<@e
      best_solution=rand(1..@mochila_old.objetos.length-1)
      f_best=@mochila_old.objetos[best_solution.to_i].peso
      i=0
      while i<@e
        locus=@evolution.get_locus(best_solution)
        new_best=@evolution.mutacion(best_solution,locus)
        f_new=@mochila_old.objetos[new_best].peso
        if f_new <= f_best
          if !@mochila_new.in_knapsack[f_new]
            if @mochila_new.get_peso_in_knapsack+f_new<=@mochila_new.max_peso
              f_best=f_new
              best_solution=new_best
              object_in_new_knapsack(best_solution)
              if best_solution==0
                best_solution=rand(1..@mochila_old.objetos.length-1)
                f_best=@mochila_old.objetos[best_solution.to_i].peso
              end
            end
          end
        end
        i=i+1
      end
      if @mochila_new.get_beneficio_in_knapsack>@mochila_old.get_beneficio_in_knapsack
        break
      else
        @mochila_new.in_knapsack.each{|i|
          i=false
        }
      end
      j=j+1
    end
    if @mochila_new.get_beneficio_in_knapsack<@mochila_old.get_beneficio_in_knapsack
      puts "\nSe encontro un maximo local pero la vieja mochila es la mejor respuesta"
    else
      puts "\nSe encontro una mejor solucion a la predeterminada en la iteracion #{j},#{i}"
    end
  end

end
