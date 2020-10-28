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

  def sa_algorithm(max_iter,index)
    # Genera una solucion aleatoria en todos los puntos
    @lista_x.asigna_all
    e_old=@lista_x.evaluar(index)
    str="Primer solucion de minimo encontrado: #{@lista_x.to_s}\n\t"+
        "Con valor en funcion de: #{e_old}\n\n"
    # Inicializa la temperatura con el maximo de temperatura
    t=@max_temp
    t_min=0.01
    @alpha=rand(0.88..0.99)
    j=0
    mejor=Punto.new(@dimension)

    while t>t_min && j<max_iter
      i=0
      while i<@max_iteracion && j<max_iter
        vecino=rand(@lista_x.dimension-1)
        old_v=@lista_x.lista_xi[vecino]
        @lista_x.asigna_p(vecino)
        e_new=@lista_x.evaluar(index)
        delta=e_new-e_old
        if delta>0
          if rand(0.0..1.0)>= Math.exp(-delta/t)
            @lista_x.lista_xi[vecino]=old_v
          else
            e_old=e_new
          end
        else
          e_old=e_new
          @lista_x.lista_xi.each_with_index{|i,j|
            mejor.lista_xi[j]=i
          }
        end
        i+=1
        j+=1
      end
      t*=@alpha
    end
    str+="Solucion de minimo encontrado: #{@lista_x.to_s}\n\t"+
        "Con valor en funcion de: #{e_old}\n\n"
        #   [0, 1,    2,3,4]
    return [str,@lista_x.evaluar(index),t,i,mejor.evaluar(index)]
  end
end
dim=30
max_iter=3
temp_max=1000
funMin=Sa_class.new(dim,max_iter,temp_max)
funciones=["Alpine","Dixon","Quintic","Schwefel","Streched","Sum Squares"]
f=File.open("resultados2.txt","w")
for j in 0..19
  for i in 0..5
    start=Time.now
    lista=funMin.sa_algorithm(500,i)
    finish=Time.now
    time=finish-start
    f.write "Iteracion #{j} de funcion #{funciones[i]}\n"+
    "Tiempo de ejecucion: #{sprintf("%.2f",time*1000)} ms\n"+
    "Mejor respuesta: #{sprintf("%.2f",lista[-1])}\n"+
    "Respuesta del algoritmo #{sprintf("%.2f",lista[1])}\n"+
    "Temperatura: #{sprintf("%.2f",lista[2])}\nIteracion "+
    "de imax: #{lista[3]}\n\n"
  end
end
f.close
