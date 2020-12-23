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

  def algoritmo(poblacion=0,type=0,gen_or_stacionary=0,selection=0)
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
          #puts "Solucion #{j}, con valores: #{@p.get_coord(i)}\tevaludo: "+
          #  "#{sprintf("%.2f",arr_eval[-1])}"
        }
      end
      s=Seleccion.new(arr_eval)
      if selection==0
        p1=s.torneo
        p2=s.torneo
      elsif selection==1
        p1=s.ruleta
        p2=s.ruleta
      else
        p1=s.proporcional
        p2=s.proporcional
      end
      #puts "\tSeleccion por: #{(selection==0?("Torneo"):selection==1?("Ruleta"):("proporcional"))}\tPadre 1: #{p1}\tPadre 2: #{p2}"
      c=Crossover.new(arr_sol[p1],arr_sol[p2])
      c.aritmetic
      c1=c.child1
      c2=c.child2
      #puts "\t\tCruza aritmetica\n\tHijo 1: #{@p.get_coord(c1)}\t"+
      #  "Hijo 2: #{@p.get_coord(c2)}"
      m=Mutation.new(c1)
      if type==0 # Alpine
        m.mut_real(-10.0/rand(1..8).to_f,10.0/rand(1..7).to_f,0.05)
        c1=m.array
        m.mut_real(-10.0/rand(1..8).to_f,10.0/rand(1..7).to_f,0.05)
        c2=m.array
      elsif type==2 # Quintic
        m.mut_real(2.47,2.479,0.25)
        c1=m.array
        m.mut_real(2.47,2.479,0.25)
        c2=m.array
      elsif type==5 # Sum Cuadrados
        m.mut_real(-5.0/(type*rand(1..40)).to_f,5.0/(type*rand(1..39)).to_f,0.35)
        c1=m.array
        m.mut_real(-5.0/(type*rand(1..40)).to_f,5.0/(type*rand(1..39)).to_f,0.35)
        c2=m.array
      else # Los demas
        m.mut_real(-10.0/(type*rand(1..30)).to_f,10.0/(type*rand(1..9)).to_f,0.5)
        c1=m.array
        m.mut_real(-10.0/(type*rand(1..30)).to_f,10.0/(type*rand(1..9)).to_f,0.5)
        c2=m.array
      end
      #puts "\t\tMutacion aritmetica\n\tHM1: #{@p.get_coord(c1)}\t"+
      # "HM2: #{@p.get_coord(c2)}"
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
