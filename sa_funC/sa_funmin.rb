#!/usr/bin/env ruby
require "./sa_class.rb"
puts "Hola bienvenido al Minimum Function Problem x_{i}^{2}"
dim=3
max_iteracion=100
temp_max=1000
puts "Deseas modificar el numero de dimensiones de x_{i}\n\t"+
      "Actualmente la dimension default es #{dim}"
dim=gets.chomp.to_i
puts "Deseas modificar el maximo numero de iteraciones\n\t"+
      "Actualmente el maximo de iteraciones es #{max_iteracion}"
max_iteracion=gets.chomp.to_i
puts "Deseas modificar la temperatura maxima del problema?\n\t"+
      "Actualmente el programa cuenta con una temperatura maxima de #{temp_max}"
temp_max=gets.chomp.to_i
print "Presiona Enter para presentar la desplegar el algoritmo..."
gets
funMin=Sa_class.new(dim,max_iteracion,temp_max)
puts "\n#{funMin.sa_algorithm}"
