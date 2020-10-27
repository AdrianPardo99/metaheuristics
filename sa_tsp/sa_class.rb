#!/usr/bin/env ruby
require "./grafo.rb"
class Sa_class
  attr_accessor :grafo,:max_iteracion,:max_temp
  def initialize(max_iteracion=100,max_temp=1000)
    @grafo=Grafo.new
    @max_iteracion=max_iteracion
    @max_temp=max_temp
  end

  def add_vertex_g(index,costo,go_to)
    @grafo.add_vertex(index,costo,go_to)
  end

  def sa_algorithm()
    @grafo.genera_sol_aleatoria
    str="Solucion inicial:\n#{@grafo.to_s}Con costo: #{@grafo.get_costo_t}\n"
    # Inicializa la temperatura con el maximo de temperatura
    t=@max_temp
    e_old=@grafo.get_costo_t
    t_min=0.01
    @alpha=rand(0.88..0.99)
    while t>t_min
      i=0
      while i<@max_iteracion
        old=@grafo
        vecino=rand(@grafo.vertices.length-1)
        @grafo.permuta(vecino)
        e_new=@grafo.get_costo_t
        delta=e_new-e_old
        if delta>0
          if rand(0.0..1.0)>=Math.exp(-delta/t)
            @grafo=old
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
    str+="Solucion:\n#{@grafo.to_s}Con costo: #{@grafo.get_costo_t}\n"
    str
  end

end
