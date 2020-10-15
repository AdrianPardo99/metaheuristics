#!/usr/bin/env ruby
require "./punto.rb"
require "./heuristicas.rb"
class Rmhc_class
  attr_accessor :lista_x,:max_iteracion,:dimension
  def initialize(dimension=1,max_iteracion=100)
    @dimension=dimension
    @max_iteracion=max_iteracion
    @lista_x=Punto.new(@dimension)
    @evolution=Heuristicas.new
  end

  def rmhc()
    @lista_x.asigna_all
    lista_puntos=Array.new(@lista_x.dimension)
    best_solution=@evolution.random_string(@lista_x.lista_xi)
    cadena=@evolution.n_to_b_s(best_solution)
    cadena.each_with_index{|i,j|
      @lista_x.asigna_p(j)
    }
    f_best=@lista_x.evaluar
    i=0
    @mejor_iteracion=[-1]
    puts "Primer solucion de minimo encontrado: #{@lista_x.to_s}\n\t"+
        "Con valor en funcion de: #{@lista_x.evaluar}"
    while i<@max_iteracion
      locus=@evolution.get_locus(best_solution)
      new_best=@evolution.evolution(locus,best_solution).to_i
      cadena=@evolution.n_to_b_s(new_best)
      cadena.each_with_index{|i,j|
        lista_puntos[j]=@lista_x.lista_xi[j]
        @lista_x.asigna_p(j)
      }
      f_new=@lista_x.evaluar
      if f_new<=f_best
        @mejor_iteracion.push(i)
        if f_new==f_best
          @mejor_iteracion.pop
        end
        best_solution=new_best
        f_best=f_new
      else
        cadena.each_with_index{|i,j|
          @lista_x.lista_xi[j]=lista_puntos[j]
          lista_puntos[j]=0
        }
      end
      i+=1
    end
    puts "Mejor solucion de minimo encontrado: #{@lista_x.to_s}\n\t"+
        "Con valor en funcion de: #{@lista_x.evaluar}\n\tEn la iteracion #{@mejor_iteracion[-1]}"
  end

end
start=Time.now
funmin_x=Rmhc_class.new(10,500)
funmin_x.rmhc
finish=Time.now
time=finish-start
puts "Tiempo de ejecucion en busqueda de la solucion #{time*1000} ms"
