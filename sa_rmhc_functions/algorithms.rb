#!/usr/bin/env ruby
require "./metaheuristic.rb"
if ARGV.length<2
  puts "Error: Usage #{$0} <Dimension> <File>"
  exit
end
dim=ARGV[0].to_i
file_name=ARGV[1]
algorithm=Metaheuristic.new(dim,dim,1000,500)
lista_funciones=["Alpine","Dixon","Quintic","Schwefel","Streched","Sum Squares"]
f=File.open(file_name,"w")
f.write("Formato de solucion RMHC\nSol_al\tIteracion_donde_se_encontro_un_minimo\tSol_final_algoritmo\n")
f.write("Formato de solucion SA\nSol_al\tAlpha\tT_max\tT_min\tT_final\tIteracion_donde_se_encontro_un_minimo\tSol_final_algoritmo\tSol_mejor\n")
for i in 0..19
  for j in 0..5
    f.write "Iteracion #{i+1} Function: #{lista_funciones[j]}\n\tDimension: #{dim}\nRMHC Algorithm\n"
    start=Time.now
    rmhc=algorithm.rmhc(j)
    finish=Time.now
    time=finish-start
    stime=sprintf("%.2f",time*1000)
    stime.sub!(".",",")
    f.write "\tTiempo de ejecucion: #{stime} ms\n"
    rmhc.each{|i|
      i.sub!(".",",")
      f.write "\t#{i}"}
    f.write "\nSA Algorithm\n"
    start=Time.now
    sa=algorithm.sa(j)
    finish=Time.now
    time=finish-start
    stime=sprintf("%.2f",time*1000)
    stime.sub!(".",",")
    f.write "\tTiempo de ejecucion: #{stime} ms\n"
    sa.each{|i|
      i.sub!(".",",")
      f.write "\t#{i}"}
    f.write "\n\n"
  end
end
f.close
