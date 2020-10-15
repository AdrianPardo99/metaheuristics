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

  def rmhc(index)
    @lista_x.asigna_all
    lista_puntos=Array.new(@lista_x.dimension)
    best_solution=@evolution.random_string(@lista_x.lista_xi)
    cadena=@evolution.n_to_b_s(best_solution)
    cadena.each_with_index{|i,j|
      @lista_x.asigna_p(j)
    }
    f_best=@lista_x.evaluar(index)
    i=0
    @mejor_iteracion=[-1]
    #puts "Primer solucion de minimo encontrado: #{@lista_x.to_s}\n\t"+
    #    "Con valor en funcion de: #{sprintf('%.2f',@lista_x.evaluar(index))}"
    while i<@max_iteracion
      locus=@evolution.get_locus(best_solution)
      new_best=@evolution.evolution(locus,best_solution).to_i
      cadena=@evolution.n_to_b_s(new_best)
      cadena.each_with_index{|i,j|
        lista_puntos[j]=@lista_x.lista_xi[j]
        @lista_x.asigna_p(j)
      }
      f_new=@lista_x.evaluar(index)
      if f_new.abs<=f_best.abs
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
    #puts "Mejor solucion de minimo encontrado: #{@lista_x.to_s}\n\t"+
    return "Con valor en funcion de: #{sprintf('%.2f',@lista_x.evaluar(index))}\tEn la iteracion #{@mejor_iteracion[-1]}"
  end

end
funmin_x=Rmhc_class.new(10,500)
f=File.open("resultados.txt","w")
for i in 0..19
  # Alpine
  start=Time.now
  str=funmin_x.rmhc(0)
  finish=Time.now
  time=finish-start
  f.write "Iteracion #{i+1}\n"
  puts "#{str}\nTiempo de ejecucion en busqueda de la solucion de Alpine #{time*1000} ms\n\n"
  f.write "#{str}\nTiempo de ejecucion en busqueda de la solucion de Alpine #{time*1000} ms\n\n"
  # Dixon
  start=Time.now
  str=funmin_x.rmhc(1)
  finish=Time.now
  time=finish-start
  puts "#{str}\nTiempo de ejecucion en busqueda de la solucion de Dixon #{time*1000} ms\n\n"
  f.write "#{str}\nTiempo de ejecucion en busqueda de la solucion de Dixon #{time*1000} ms\n\n"
  # Quintic
  start=Time.now
  str=funmin_x.rmhc(2)
  finish=Time.now
  time=finish-start
  puts "#{str}\nTiempo de ejecucion en busqueda de la solucion de Quintic #{time*1000} ms\n\n"
  f.write "#{str}\nTiempo de ejecucion en busqueda de la solucion de Quintic #{time*1000} ms\n\n"
  # Schwefel
  start=Time.now
  str=funmin_x.rmhc(3)
  finish=Time.now
  time=finish-start
  puts "#{str}\nTiempo de ejecucion en busqueda de la solucion de Schwefel #{time*1000} ms\n\n"
  f.write "#{str}\nTiempo de ejecucion en busqueda de la solucion de Schwefel #{time*1000} ms\n\n"

  # Streched
  start=Time.now
  str=funmin_x.rmhc(4)
  finish=Time.now
  time=finish-start
  puts "#{str}\nTiempo de ejecucion en busqueda de la solucion de Streched #{time*1000} ms\n\n"
  f.write "#{str}\nTiempo de ejecucion en busqueda de la solucion de Streched #{time*1000} ms\n\n"

  # Sum Squares
  start=Time.now
  str=funmin_x.rmhc(5)
  finish=Time.now
  time=finish-start
  puts "#{str}\nTiempo de ejecucion en busqueda de la solucion de Sum Squares #{time*1000} ms\n\n"
  f.write "#{str}\nTiempo de ejecucion en busqueda de la solucion de Sum Squares #{time*1000} ms\n\n\n\n"
end
f.close
