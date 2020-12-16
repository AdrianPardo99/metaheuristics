#!/usr/bin/env ruby

require "./ga.rb"
puts "Hola bienvenido a optimizacion de funciones en D dimensiones"+
      " con GA Estacionario"
dimension=3
max_iteration=100
poblacion=10
puts "Deseas modificar la dimension por defecto que tiene el problema?\n\t"+
      "Actualmente la dimension es #{dimension}"
dimension=gets.chomp.to_i
puts "Deseas modificar el maximo numero de iteraciones que tiene el problema?\n\t"+
      "Actualmente el programa cuenta con un limite de iteraciones de #{max_iteration}"
max_iteration=gets.chomp.to_i
puts "Deseas modificar el numero de ploblacion que generara el problema?\n\t"+
      "Actualmente el programa cuenta con un numero de ploblacion de #{poblacion}"
poblacion=gets.chomp.to_i
ga=GA.new(max_iteration,dimension)
print "Por favor presione enter para continuar..."
gets.chomp
puts "#{ga.algoritmo(poblacion)}"
