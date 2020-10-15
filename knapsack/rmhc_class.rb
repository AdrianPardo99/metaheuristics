#!/usr/bin/env ruby
require "./mochila.rb"
require "./heuristicas.rb"
class Rmhc_class
  attr_accessor :mochila,:max_iteracion
  def initialize(mochila=Mochila.new([],10),max_iteracion=100)
    @mochila=mochila
    @max_iteracion=max_iteracion
    @evolution=Heuristicas.new
  end

  def add_objeto(peso,beneficio)
    @mochila.add_elemento(peso,beneficio)
  end

  def rmhc()
    @nueva_solucion=Mochila.new(@mochila.lista_objetos,@mochila.peso_max)
    best_solution=0
    i=0
    @mejor_iteracion=[-1]
    # Validacion de que la primer respuesta sea valida
    loop{
      best_solution=@evolution.random_string(@mochila.lista_objetos)
      cadena=@evolution.n_to_b_s(best_solution)
      cadena.each_with_index{|v,i|
        if v==1
          @nueva_solucion.lista_objetos[i].selected=true
        end
      }
      if @nueva_solucion.get_all_peso<=@nueva_solucion.peso_max and @nueva_solucion.get_all_peso>0
        break
      else
        @nueva_solucion.lista_objetos.each{|i|i.selected=false}
      end
    }
    f_best=@nueva_solucion.get_all_beneficio
    str="Solucion inicial\n#{@nueva_solucion.to_s}\nPeso total: #{@nueva_solucion.get_all_peso}\n"+
          "Con beneficio: #{@nueva_solucion.get_all_beneficio}\n"
    while i<@max_iteracion
      locus=@evolution.get_locus(best_solution)
      new_best=@evolution.evolution(locus,best_solution).to_i
      new_best.times{|j| @nueva_solucion.lista_objetos[j].selected=!@nueva_solucion.lista_objetos[j].selected}
      f_new=@nueva_solucion.get_all_beneficio
      peso_new=@nueva_solucion.get_all_peso
      if f_new>=f_best and peso_new<=@nueva_solucion.peso_max
        @mejor_iteracion.push(i)
        if f_new==f_best
          @mejor_iteracion.pop
        end
        best_solution=new_best
        f_best=f_new
      elsif f_new>@nueva_solucion.peso_max
        new_best.times{|j| @nueva_solucion.lista_objetos[j].selected=!@nueva_solucion.lista_objetos[j].selected}
      end
      i+=1
    end
    str+="\n\nSolucion encontrada\n#{@nueva_solucion.to_s}\nPeso total: #{@nueva_solucion.get_all_peso}\n"+
      "Con beneficio: #{@nueva_solucion.get_all_beneficio}\nEn la iteracion #{@mejor_iteracion[-1]}"
    str
  end
end
