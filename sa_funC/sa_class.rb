#!/usr/bin/env ruby
require "./punto.rb"
class Sa_class
  attr_accessor :lista_x,:max_iteracion,:dimension,:max_temp
  def initialize(dimension=1,max_iteracion=100,max_temp=1000)
    @dimension=dimension
    @max_iteracion=max_iteracion
    @max_temp=max_temp
    @lista_x=Punto.new(@dimension)
  end

  def sa_algorithm()
    # Genera una solucion aleatoria en todos los puntos
    @lista_x.asigna_all
    str="Primer solucion de minimo encontrado: #{@lista_x.to_s}\n\t"+
        "Con valor en funcion de: #{@lista_x.evaluar}\n\n"
    # Inicializa la temperatura con el maximo de temperatura
    t=@max_temp
    e_old=@lista_x.evaluar
    t_min=0.01
    @alpha=rand(0.88..0.99)
    while t>t_min
      i=0
      while i<@max_iteracion
        vecino=rand(@lista_x.dimension-1)
        old_v=@lista_x.lista_xi[vecino]
        @lista_x.asigna_p(vecino)
        e_new=@lista_x.evaluar
        delta=e_new-e_old
        if delta>0
          if rand(0.0..1.0)>= Math.exp(-delta/t)
            @lista_x.lista_xi[vecino]=old_v
          else
            e_old=e_new
          end
        else
          e_old=e_new
        end
        i+=1
      end
      t*=@alpha
    end
    str+="Solucion de minimo encontrado: #{@lista_x.to_s}\n\t"+
        "Con valor en funcion de: #{@lista_x.evaluar}\n\n"
  end
end
