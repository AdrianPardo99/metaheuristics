#!/usr/bin/env ruby
require "./mochila.rb"
require "./heuristicas.rb"
class Sa_class
  attr_accessor :mochila,:alpha,:max_iteracion,:max_temp
  def initialize(mochila=Mochila.new([],10),max_iteracion=100,max_temp=1000)
    @mochila=mochila
    @max_temp=max_temp
    @max_iteracion=max_iteracion
    @evolution=Heuristicas.new
  end

  def add_objeto(peso,beneficio)
    @mochila.add_elemento(peso,beneficio)
  end

  def sa_algorithm()
    # Validacion de que la primer respuesta sea valida
    loop{
      # Reutiliza el codigo de la version RMHC para crear la primer
      #  solucion aleatoria
      best_solution=@evolution.random_string(@mochila.lista_objetos)
      cadena=@evolution.n_to_b_s(best_solution)
      cadena.each_with_index{|v,i|
        if v==1
          @mochila.lista_objetos[i].selected=true
        end
      }
      if @mochila.get_all_peso<=@mochila.peso_max
        break
      else
        @mochila.lista_objetos.each{|i|i.selected=false}
      end
    }

    str="Solucion inicial\n#{@mochila.to_s}\nPeso total: #{@mochila.get_all_peso}\n"+
      "Con beneficio: #{@mochila.get_all_beneficio}\n\n"
    # Inicializa la temperatura con el maximo de temperatura
    t=@max_temp
    e_old=@mochila.get_all_beneficio
    t_min=0.01
    @alpha=rand(0.88..0.99)
    while t>t_min
      i=0
      while i<@max_iteracion
        # Evoluciona a 1 casilla vecina y verifica si es valido el movimiento
        vecino=0
        loop{
          vecino=rand(@mochila.lista_objetos.length-1)
          if !@mochila.lista_objetos[vecino].selected
            p=@mochila.lista_objetos[vecino].peso+@mochila.get_all_peso
            if p<=@mochila.peso_max
              @mochila.lista_objetos[vecino].selected=!@mochila.lista_objetos[vecino].selected
              break
            end
          else
            @mochila.lista_objetos[vecino].selected=!@mochila.lista_objetos[vecino].selected
            break
          end
        }
        e_new=@mochila.get_all_beneficio
        delta=e_old-e_new
        if delta>0
          if rand(0.0..1.0)>= Math.exp(-delta/t)
            @mochila.lista_objetos[vecino].selected=!@mochila.lista_objetos[vecino].selected
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
    str+="Solucion final\n#{@mochila.to_s}\nPeso total: #{@mochila.get_all_peso}\n"+
      "Con beneficio: #{@mochila.get_all_beneficio}\n\n"
  end
end
