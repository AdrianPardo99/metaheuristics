#!/usr/bin/env ruby
require "./sa_class.rb"
require "./fileLoader.rb"
puts "Hola bienvenido al Knapsack Problem"
peso_max=15
max_iteration=200
temp_max=1000
puts "Deseas modificar el peso por defecto que tiene el problema?\n\t"+
      "Actualmente el peso maximo es #{peso_max}"
peso_max=gets.chomp.to_i
puts "Deseas modificar el maximo numero de iteraciones que tiene el problema?\n\t"+
      "Actualmente el programa cuenta con un limite de iteraciones de #{max_iteration}"
max_iteration=gets.chomp.to_i
puts "Deseas modificar la temperatura maxima del problema?\n\t"+
      "Actualmente el programa cuenta con una temperatura maxima de #{temp_max}"
temp_max=gets.chomp.to_i
files=read_file(".")
puts "A continuacion se te mostrara el listado\n\tde archivos encontrados \n\tpara"+
      " trabajar y resolver\n\tel problema con diferentes \n\tconfiguraciones"

files.each_with_index{|i,ind|
  puts "[#{ind+1}]\t#{i}"
}
puts "Por favor ingresa el indice del archivo"
index_file=gets.chomp.to_i
file=File.open(files[index_file-1])
data=file.read
data=data.split("\n")
file.close
print "Presiona Enter para presentar la desplegar el algoritmo..."
gets
knapsack=Sa_class.new(Mochila.new([],peso_max),max_iteration,temp_max)
data.each{|j|
  a=j.split(",").map(&:to_i)
  knapsack.add_objeto(a[0],a[1])
}
Gem.win_platform? ? (system "cls") : (system "clear")
puts "Muestra de objetos de la mochila\n#{knapsack.mochila.to_s_all}"
puts knapsack.sa_algorithm
