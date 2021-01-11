#!/usr/bin/env ruby

require "./ga.rb"

dimension=10
max_iteration=500
poblacion=10
ga=GA.new(max_iteration,dimension)
f=File.open("resultados.txt","w")
2.times{|l|
  3.times{|m|
    6.times{|i|
      f.write "#{(i==0?("Alpine function con p=0.05"):i==1?("Dixon function con p=0.5"):
        i==2?("Quintic function p=0.25"):i==3?("Schwefel function p=0.5"):
        i==4?("Streched function p=0.5"):("Sum Squares function p=0.35"))}"+
        " #{(l==0?("Stacionary GA"):("Generational GA"))}\n"+
        "#{(m==0)?("Torneo"):(m==1?("Ruleta"):("Proporcional"))}\n"
      f.write "Iteracion,Tiempo_ms,#{(l%2==0?(""):("Gen_sol,Iter_gen,Sol_gen,"))}Sol,Iter_sol,Dimension\n"
      2.times{|k|
        ga.dimension=(k==0?10:30)
        20.times{|j|
          start=Time.now
          str_sol=ga.algoritmo(poblacion,i,l,m)
          finish=Time.now
          time=finish-start
          f.write "#{j+1},#{sprintf("%.2f",time*1000)},#{str_sol},#{ga.dimension}\n"
        }
      }
    }
  }
}

f.close
