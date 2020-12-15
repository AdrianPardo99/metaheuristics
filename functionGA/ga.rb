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

  def algoritmo(poblacion=0)
    arr_sol=[]
    thread=[]
    poblacion.times{|i|
      thread<<Thread.new{
        arr_sol.push(gen_sol)
      }
    }
    thread.each{|i|i.join}
    iter=0
    while iter<@max_iteration
      arr_eval=[]
      arr_sol.each_with_index{|i,j|
        arr_eval.push(@p.get_eval(i))
        #puts "Solucion #{j}, con valores: #{@p.get_coord(i)}\tevaludo: "+
        #  "#{sprintf("%.2f",arr_eval[-1])}"
      }
      s=Seleccion.new(arr_eval)
      p1=s.torneo
      p2=s.torneo
      #puts "\tPadre 1: #{p1}\tPadre 2: #{p2}"
      c=Crossover.new(arr_sol[p1],arr_sol[p2])
      c.aritmetic
      c1=c.child1
      c2=c.child2
      #puts "\t\tCruza aritmetica\n\tHijo 1: #{@p.get_coord(c1)}\t"+
      #  "Hijo 2: #{@p.get_coord(c2)}"
      m=Mutation.new(c1)
      m.mut_real(-10.0,10.0,0.05)
      c1=m.array
      m.array=c2
      m.mut_real(-10.0,10.0,0.05)
      c2=m.array
      #puts "\t\tMutacion aritmetica\n\tHM1: #{@p.get_coord(c1)}\t"+
      # "HM2: #{@p.get_coord(c2)}"
      ec1=@p.get_eval(c1)
      ec2=@p.get_eval(c2)
      r=Replacement.new([@p.get_eval(arr_sol[p1])],[@p.get_eval(arr_sol[p2])],
        [ec1],[ec2])
      # Opcion de Minimizacion
      string=r.elitism(0)
      if !string.include?(:p1)||!string.include?(:p2)
        if !string.include?:p1
          if string.include?:p2
            arr_sol[p1]=arr_sol[p2]
          elsif string.include?(:c1)
            arr_sol[p1]=c1
          elsif string.include?(:c2)
            arr_sol[p1]=c2
          end
        end
        if !string.include?:p2
          if string.include?:p1
            arr_sol[p2]=arr_sol[p1]
          elsif string.include?(:c1)
            arr_sol[p2]=c1
          elsif string.include?(:c2)
            arr_sol[p2]=c2
          end
        end
      end
      arr_sol_new=[arr_sol[p1],arr_sol[p2]]
      thread.clear
      (poblacion-2).times{|i|
        thread<<Thread.new{arr_sol_new.push(gen_sol)}
      }
      thread.each{|i|i.join}
      arr_sol=arr_sol_new
      iter+=1
    end
    mejor=0
    str="Soluciones de la poblacion:\n"
    sol=""
    arr_sol.each_with_index{|i,j|
      str+="\tSolucion #{j} en puntos #{@p.get_coord(i)} y funcion: "+
            "#{sprintf("%.2f",@p.get_eval(i))}\n"
    }

    arr_sol.each_with_index{|i,j|
      if @p.get_eval(i)<=@p.get_eval(arr_sol[mejor])
        mejor=j
        sol="Solucion mejor obtenida con indice #{j}\n\t"+
            "En los puntos: #{@p.get_coord(i)} y funcion evaluada:"+
            " #{sprintf("%.2f",@p.get_eval(i))}"
      end
    }
    str+=sol
    str
  end
end

#ga=GA.new(100,3)
#puts ga.algoritmo(10)
