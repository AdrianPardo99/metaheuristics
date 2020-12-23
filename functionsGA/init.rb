#!/usr/bin/env ruby

require "./ga.rb"

dimension=10
max_iteration=100
poblacion=10
ga=GA.new(max_iteration,dimension)
f=File.open("resultados.txt","w")
6.times{|i|
  f.write "#{(i==0?("Alpine function"):i==1?("Dixon function"):
  i==2?("Quintic function"):i==3?("Schwefel function"):
  i==4?("Streched function"):("Sum Squares function"))}"+
  " #{(i%2==0?("Stacionary GA"):("Generational GA"))}\n"
  f.write "Iteracion,Tiempo_ms,#{(i%2==0?(""):("Gen_sol,Iter_gen,Sol_gen,"))}Sol,Iter_sol,Dimension\n"
  2.times{|k|
    ga.dimension=(k==0?10:30)
    20.times{|j|
      start=Time.now
      str_sol=ga.algoritmo(poblacion,i,(i%2),(i%3))
      finish=Time.now
      time=finish-start
      f.write "#{j+1},#{sprintf("%.2f",time*1000)},#{str_sol},#{ga.dimension}\n"
    }
  }
}

f.close
