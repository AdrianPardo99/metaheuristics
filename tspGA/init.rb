#!/usr/bin/env ruby
require "./fileLoader.rb"
require "./ga.rb"
puts "Hola bienvenido al Travel Salesman Problem TSP con GA Estacionario"
max_iteration=100
poblacion=10

puts "Deseas modificar el maximo numero de iteraciones que tiene el problema?\n\t"+
      "Actualmente el programa cuenta con un limite de iteraciones de #{max_iteration}"
max_iteration=gets.chomp.to_i
puts "Deseas modificar el numero de ploblacion que generara el problema?\n\t"+
      "Actualmente el programa cuenta con un numero de ploblacion de #{poblacion}"
poblacion=gets.chomp.to_i

files=read_file(".")
puts "A continuacion se te mostrara el listado de archivos encontrados para"+
      " trabajar y resolver el problema con diferentes configuraciones"

files.each_with_index{|i,ind|
  puts "[#{ind+1}]\t#{i}"
}
puts "Por favor ingresa el indice del archivo"
index_file=gets.chomp.to_i
file=File.open(files[index_file-1])
data=file.read
data=data.split("\n")
file.close
arr_table=[]
data.each{|i|
  arr_table.push(i.split(",",-1).map(&:to_i))
}
ga=GA.new(max_iteration,arr_table)
print "Por favor presione enter para continuar..."
gets.chomp
puts ga.algoritmo(poblacion)
