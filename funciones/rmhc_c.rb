#!/usr/bin/env ruby
require "./punto.rb"
require "./heuristicas.rb"
class Rmhc_c
  attr_accessor :lista_x,:max_iteracion,:dimension
  def initialize(dimension=1,max_iteracion=100)
    @dimension=dimension
    @max_iteracion=max_iteracion
    @lista_x=Punto.new(@dimension)
    @evolution=Heuristicas.new
  end

  def rmhc(index)
    #arrDouble=Array.new(@lista_x.dimension) # [0,0,0,0,0,0,0,0,0,0] double
    #arrDouble.each{|i|
    #  i=rand(-10.0..10.0)
    #}
    #indice_x=rand(arrDouble.length)
    #arrDouble[indice_x]=rand(-10.0..10.0) # Realizo una modificación sobre un indice de [-10,10]
    #evaluacion_fx=@lista_x

    @lista_x.asigna_all
    evaluacion_fx=@lista_x.evaluar(index)
    str= "Primer solucion de minimo encontrado: #{@lista_x.to_s}\n\t"+
        "Con valor en funcion de: #{sprintf('%.2f',@lista_x.evaluar(index))}"
    lista_puntos=Array.new(@lista_x.dimension) # [0,0,0,0,0,0,0,0,0,0]
    i=0
    @mejor_iteracion=[-1]
    while i<@max_iteracion
      lista_puntos.each_with_index{|i,j|
        lista_puntos[j]=@lista_x.lista_xi[j]
      }
      best_solution=@evolution.random_string(@lista_x.lista_xi) # 5 posicion
      @lista_x.asigna_p(best_solution) # Asigna un valor aleatorio entre [-10,10] en el subindice best_solution
      f_best=@lista_x.evaluar(index)

      if f_best.abs<=evaluacion_fx.abs
        @mejor_iteracion.push(i)
        if evaluacion_fx==f_best
          @mejor_iteracion.pop
        end
        evaluacion_fx=f_best
      else
        @lista_x.lista_xi[best_solution]=lista_puntos[best_solution]
      end
      i+=1
    end
    str+= "Mejor solucion de minimo encontrado: #{@lista_x.to_s}\n\t"+
          "Con valor en funcion de: #{sprintf('%.2f',evaluacion_fx)}\tEn la iteracion #{@mejor_iteracion[-1]}"
  end
end
funmin_x=Rmhc_class.new(10,500)
# Alpine
start=Time.now
str=funmin_x.rmhc(0)
finish=Time.now
time=finish-start
puts "Tiempo de ejecucion en busqueda de la solucion de Alpine #{time*1000} ms\n\n"
# Dixon
start=Time.now
str=funmin_x.rmhc(1)
finish=Time.now
time=finish-start
puts "Tiempo de ejecucion en busqueda de la solucion de Dixon #{time*1000} ms\n\n"
# Quintic
start=Time.now
str=funmin_x.rmhc(2)
finish=Time.now
time=finish-start
puts "Tiempo de ejecucion en busqueda de la solucion de Quintic #{time*1000} ms\n\n"
# Schwefel
start=Time.now
str=funmin_x.rmhc(3)
finish=Time.now
time=finish-start
puts "Tiempo de ejecucion en busqueda de la solucion de Schwefel #{time*1000} ms\n\n"

# Streched
start=Time.now
str=funmin_x.rmhc(4)
finish=Time.now
time=finish-start
puts "Tiempo de ejecucion en busqueda de la solucion de Streched #{time*1000} ms\n\n"

# Sum Squares
start=Time.now
str=funmin_x.rmhc(5)
finish=Time.now
time=finish-start
puts "Tiempo de ejecucion en busqueda de la solucion de Sum Squares #{time*1000} ms\n\n"
