#!/usr/bin/env ruby
require "./punto.rb"
class Metaheuristic
  attr_accessor :lista_x,:imax,:dimension,:max_temp,:max_iter
  def initialize(dimension=1,imax=100,max_temp=1000,max_iter=500)
    @dimension=dimension
    @imax=imax
    @max_temp=max_temp
    @max_iter=max_iter
    @lista_x=Punto.new(@dimension)
  end

  # Algorithm Random Mutation Hill Climbing
  def rmhc(index=0)
    lista_res=[]
    lista_iter=[-1]
    value=0
    @lista_x.asigna_all
    f_best=@lista_x.evaluar(index)
    i=0
    best_solution=rand(@lista_x.lista_xi.length)
    lista_res.push("Sol_al: #{sprintf("%.7f",f_best)}")
    while  i<@max_iter
      locus=rand(best_solution-1)
      new_best=rand(locus..best_solution).to_i
      values=@lista_x.lista_xi[new_best]
      @lista_x.asigna_p(new_best)
      f_new=@lista_x.evaluar(index)
      if f_new<=f_best
        lista_iter.push(i)
        if f_new==f_best
          lista_iter.pop
        end
        best_solution=new_best
        f_best=f_new
      else
        @lista_x.lista_xi[new_best]=values
      end
      i+=1
    end
    lista_res.push("Iteracion_donde_se_encontro_un_minimo: #{lista_iter[-1]}")
    lista_res.push("Sol_final_algoritmo: #{sprintf("%.7f",f_best)}")
    lista_res
  end

  # Algorithm Simulated Annealling
  def sa(index=0)
    lista_res=[]
    lista_iter=[-1]
    # Genera una solucion aleatoria en todos los puntos
    @lista_x.asigna_all
    e_old=@lista_x.evaluar(index)
    lista_res.push("Sol_al: #{sprintf("%.7f",e_old)}")
    t=@max_temp
    t_min=0.0001
    @alpha=rand(0.88..0.99)
    j=0
    mejor=Punto.new(@dimension)
    lista_res.push("Alpha: #{sprintf("%.7f",@alpha)}")
    lista_res.push("T_max: #{@max_temp}")
    lista_res.push("T_min: #{t_min}")

    while t>t_min && j<@max_iter
      i=0
      while i<@imax && j<@max_iter
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
          lista_iter.push(j)
          if delta==0
            lista_iter.pop
          end
        end
        i+=1
        j+=1
      end
      t*=@alpha
    end
    lista_res.push("T_final: #{sprintf("%.7f",t)}")
    lista_res.push("Iteracion_donde_se_encontro_un_minimo: #{lista_iter[-1]}")
    lista_res.push("Sol_final_algoritmo: #{sprintf("%.7f",@lista_x.evaluar(index))}")
    lista_res.push("Sol_mejor: #{sprintf("%.7f",mejor.evaluar(index))}")
    lista_res
  end
end
