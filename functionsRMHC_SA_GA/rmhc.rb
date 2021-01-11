#!/usr/bin/env ruby
require "./punto.rb"
class RMHC
  attr_accessor :max_iteration,:dimension
  def initialize(max_iteration=0,dimension=0)
    @max_iteration=max_iteration
    @dimension=dimension
    @p=Punto.new(@dimension)
  end

  def gen_sol()
    arreglo=[]
    @p.set_points(arreglo)
    arreglo
  end

  def algoritmo(type=0,max_evaluacion=500,inter_inf=-10.0,inter_sup=10.0)
    lista_puntos=gen_sol()
    evaluacion_fx=@p.get_eval(lista_puntos,type)
    evaluaciones=0
    while evaluaciones<max_evaluacion
      i=0
      while i<@max_iteration
        index_solution=rand(lista_puntos.length)
        lista_nuevos=lista_puntos[index_solution]
        lista_puntos[index_solution]=rand(inter_inf..inter_sup)
        f_best=@p.get_eval(lista_puntos,type)
        if f_best>evaluacion_fx
          lista_puntos[index_solution]=lista_nuevos
        else
          evaluaciones+=1
        end
        i+=1
      end
    end
    "#{sprintf('%.2f',@p.get_eval(lista_puntos))}"
  end

end
