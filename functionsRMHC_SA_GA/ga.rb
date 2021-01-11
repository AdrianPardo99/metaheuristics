#!/usr/bin/env ruby
require "./punto.rb"
require "./seleccion.rb"
require "./crossover.rb"
require "./mutation.rb"
require "./replacement.rb"
class GA
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

  def algoritmo(poblacion=0,type=0,gen_or_stacionary=0,max_evaluacion=500,inter_inf=-10.0,inter_sup=10.0)
    arr_sol=[]
    thread=[]
    arr_eval=[]
    str_solucion=""
    if gen_or_stacionary==0 # Estacionario
      poblacion.times{|i|
        thread<<Thread.new{
          arr_sol.push(gen_sol)
        }
      }
      thread.each{|i|i.join}
      arr_sol.each_with_index{|i,j|
        arr_eval.push(@p.get_eval(i,type))
        #puts "Solucion #{j}, con valores: #{@p.get_coord(i)}\tevaludo: "+
        #  "#{sprintf("%.2f",arr_eval[-1])}"
      }
    else
      mejor_eval=2**10000
    end
    evaluaciones=0
    while evaluaciones<max_evaluacion
      iter=0
      while iter<@max_iteration
        if gen_or_stacionary==1 # Generacional
          arr_sol.clear()
          thread.clear()
          arr_eval.clear()
          poblacion.times{|i|
            thread<<Thread.new{
              arr_sol.push(gen_sol)
            }
          }
          thread.each{|i|i.join}
          arr_sol.each_with_index{|i,j|
            arr_eval.push(@p.get_eval(i,type))
          }
        end
        if rand()>0.5 # Entra en todo el proceso del algoritmo genetico
          s=Seleccion.new(arr_eval)
          p1=s.torneo
          p2=s.torneo
          c=Crossover.new(arr_sol[p1],arr_sol[p2])
          c.aritmetic
          c1=c.child1
          c2=c.child2
          m=Mutation.new(c1)

          m.mut_real(inter_inf,inter_sup,0.15)
          c1=m.array
          m.mut_real(inter_inf,inter_sup,0.15)
          c2=m.array

          ec1=@p.get_eval(c1,type)
          ec2=@p.get_eval(c2,type)
          r=Replacement.new([@p.get_eval(arr_sol[p1],type)],[@p.get_eval(arr_sol[p2],type)],
            [ec1],[ec2])
          # Opcion de Minimizacion
          string=r.elitism(0)
          if !string.include?(:p1)||!string.include?(:p2)
            if !string.include?:p1
              if string.include?:p2
                arr_sol[p1]=arr_sol[p2]
                arr_eval[p1]=arr_eval[p2]
              elsif string.include?(:c1)
                arr_sol[p1]=c1
                arr_eval[p1]=ec1
              elsif string.include?(:c2)
                arr_sol[p1]=c2
                arr_eval[p1]=ec2
              end
            end
            if !string.include?:p2
              if string.include?:p1
                arr_sol[p2]=arr_sol[p1]
                arr_eval[p2]=arr_eval[p1]
              elsif string.include?(:c1)
                arr_sol[p2]=c1
                arr_eval[p2]=ec1
              elsif string.include?(:c2)
                arr_sol[p2]=c2
                arr_eval[p2]=ec2
              end
            end
          end
          evaluaciones+=1 # Incrementa porque si hace la evaluacion de la funcion
        end
        if gen_or_stacionary==1 # Generacional
          arr_sol.each_with_index{|i,j|
            if @p.get_eval(i,type)<=mejor_eval
              mejor_eval=@p.get_eval(i,type)
              str_solucion="#{iter},#{j},#{sprintf("%.2f",mejor_eval)}"
            end
          }
        end
        iter+=1
      end
    end
    mejor=0
    sol=""
    arr_sol.each_with_index{|i,j|
      if @p.get_eval(i,type)<=@p.get_eval(arr_sol[mejor],type)
        mejor=j
        sol="#{sprintf("%.2f",@p.get_eval(i,type))},#{j}"
      end
    }
    str="#{(str_solucion.empty?()?(""):("#{str_solucion},"))}#{sol}"
    str
  end
end

#ga=GA.new(100,3)
#puts ga.algoritmo(10)
