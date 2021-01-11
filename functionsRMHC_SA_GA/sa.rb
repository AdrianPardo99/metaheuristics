#!/usr/bin/env ruby
require "./punto.rb"
class SA
  attr_accessor :max_iteration,:dimension,:max_temp
  def initialize(max_iteration=0,dimension=0,max_temp=1000)
    @max_iteration=max_iteration
    @dimension=dimension
    @max_temp=max_temp
    @p=Punto.new(@dimension)
  end

  def gen_sol()
    arreglo=[]
    @p.set_points(arreglo)
    arreglo
  end

  def algoritmo(type=0,max_evaluacion=500,inter_inf=-10.0,inter_sup=10.0)
    lista_puntos=gen_sol()
    e_old=@p.get_eval(lista_puntos,type)
    t=@max_temp
    t_min=0.01
    @alpha=rand(0.88..0.99)
    j=0
    while t>t_min && j<max_evaluacion
      i=0
      while i<@max_iteration && j<max_evaluacion
        vecino=rand(lista_puntos.length)
        old_estado=lista_puntos[vecino]
        lista_puntos[vecino]=rand(inter_inf..inter_sup)
        e_new=@p.get_eval(lista_puntos,type)
        delta=e_new-e_old
        if delta>0
          if rand(0.0..1.0)>=Math.exp(-delta/t)
            lista_puntos[vecino]=old_estado
          else
            e_old=e_new
            j+=1
          end
        else
          e_old=e_new
          j+=1
        end
        i+=1
      end
      t*=@alpha
    end
    "#{sprintf('%.2f',@alpha)},#{sprintf('%.2f',@p.get_eval(lista_puntos))}"
  end
end
