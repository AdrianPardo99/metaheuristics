#!/usr/bin/env ruby

require "./rmhc.rb"
require "./sa.rb"
require "./ga.rb"

def crea_ga(type_sol=0,name_file="resultados_ga.txt")
  dimension=10
  max_iteration=500
  poblacion=10
  ga=GA.new(max_iteration,dimension)
  f=File.open(name_file,"w")
  2.times{|l|
    6.times{|i|
      f.write "#{(i==0?("Alpine function"):i==1?
        ("Dixon function"):
        i==2?("Quintic function"):i==3?("Schwefel function"):
        i==4?("Streched function"):("Sum Squares function"))}"+
        " #{(l==0?("Stacionary GA"):("Generational GA"))} #{(type_sol==0?
        ("con operadores normales"):("con operadores tramposos"))} "+
        "Por torneo\n"
      f.write "Iteracion,Tiempo_ms,#{(l%2==0?(""):
        ("Gen_sol,Iter_gen,Sol_gen,"))}Sol,Iter_sol,Dimension\n"
      2.times{|k|
        ga.dimension=(k==0?10:30)
        20.times{|j|
          start=Time.now
          if type_sol==0
            str_sol=ga.algoritmo(poblacion,i,l,500)
          else
            # Operadores tramposos
            if i==2
              str_sol=ga.algoritmo(poblacion,i,l,500,2.47,2.479)
            else
              str_sol=ga.algoritmo(poblacion,i,l,
                500,-10.0/rand(8..40).to_f,10.0/rand(8..30).to_f)
            end
          end
          finish=Time.now
          time=finish-start
          f.write "#{j+1},#{sprintf("%.2f",time*1000)},#{str_sol},"+
            "#{ga.dimension}\n"
        }
      }
    }
  }
  puts "Salio la evaluacion de algoritmos geneticos "+
    "#{(type_sol==0?("con operadores normales"):("con operadores tramposos"))}"
  f.close
end

def crea_rmhc(type_sol=0,name_file="resultados_rmhc.txt")
  dimension=10
  max_iteration=500
  f=File.open(name_file,"w")
  rmhc=RMHC.new(max_iteration,dimension)
  6.times{|i|
    f.write "#{(i==0?("RMHC Alpine function"):i==1?("RMHC Dixon function"):
      i==2?("RMHC Quintic function"):i==3?("RMHC Schwefel function"):
      i==4?("RMHC Streched function"):("RMHC Sum Squares function"))} "+
      "#{(type_sol==0?("con operadores normales"):
      ("con operadores tramposos"))}\n"
    f.write "Iteracion,Tiempo_ms,Solucion,Dimension\n"
    2.times{|k|
      rmhc.dimension=(k==0?10:30)
      20.times{|j|
        start=Time.now
        if type_sol==0
          str_sol=rmhc.algoritmo(i,500,-10.0,10.0)
        else
          # Operadores tramposos
          if i==2
            str_sol=rmhc.algoritmo(i,500,2.47,2.479)
          else
            str_sol=rmhc.algoritmo(i,500,-10.0/rand(8..40).to_f,
              10.0/rand(8..30).to_f)
          end
        end
        finish=Time.now
        time=finish-start
        f.write "#{j+1},#{sprintf("%.2f",time*1000)},#{str_sol},"+
          "#{rmhc.dimension}\n"
      }
    }
  }
  puts "Salio la evaluacion de RMHC #{(type_sol==0?("con operadores normales"):
    ("con operadores tramposos"))}"
  f.close
end

def crea_sa(type_sol=0,name_file="resultados_sa.txt")
  dimension=10
  max_iteration=500
  f=File.open(name_file,"w")
  sa=SA.new(max_iteration,dimension,1000)
  6.times{|i|
    f.write "#{(i==0?("SA Alpine function"):i==1?("SA Dixon function"):
      i==2?("SA Quintic function"):i==3?("SA Schwefel function"):
      i==4?("SA Streched function"):("SA Sum Squares function"))} "+
      "#{(type_sol==0?("con operadores normales"):
      ("con operadores tramposos"))}\n"
    f.write "Iteracion,Tiempo_ms,Alpha,Solucion,Dimension\n"
    2.times{|k|
      sa.dimension=(k==0?10:30)
      20.times{|j|
        start=Time.now
        if type_sol==0
          str_sol=sa.algoritmo(i,500,-10.0,10.0)
        else
          # Operadores tramposos
          if i==2
            str_sol=sa.algoritmo(i,500,2.47,2.479)
          else
            str_sol=sa.algoritmo(i,500,-10.0/rand(8..40).to_f,10.0/rand(8..30).to_f)
          end
        end
        finish=Time.now
        time=finish-start
        f.write "#{j+1},#{sprintf("%.2f",time*1000)},#{str_sol},#{sa.dimension}\n"
      }
    }
  }
  puts "Salio la evaluacion de SA #{(type_sol==0?("con operadores normales"):
    ("con operadores tramposos"))}"
  f.close
end

def thread_eval(index)
  case index
  when 0
    crea_ga()
  when 1
    crea_rmhc()
  when 2
    crea_sa()
  when 3
    crea_ga(1,"resultados_ga_tramposo.txt")
  when 4
    crea_rmhc(1,"resultados_rmhc_tramposo.txt")
  else
    crea_sa(1,"resultados_sa_tramposo.txt")
  end

end

threads=[]
6.times{|i|
  threads<<Thread.new{
    puts "Entrando al hilo #{i}"
    thread_eval(i)
  }
}
threads.each{|t|t.join}
