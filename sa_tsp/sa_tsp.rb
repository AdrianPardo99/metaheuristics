#!/usr/bin/env ruby
require "./sa_class"
max_iteracion=100
temp_max=1000
puts "Deseas modificar el maximo numero de iteraciones\n\t"+
      "Actualmente el maximo de iteraciones es #{max_iteracion}"
max_iteracion=gets.chomp.to_i
puts "Deseas modificar la temperatura maxima del problema?\n\t"+
      "Actualmente el programa cuenta con una temperatura maxima de #{temp_max}"
temp_max=gets.chomp.to_i
print "Presiona Enter para presentar la desplegar el algoritmo..."
gets

g=Sa_class.new(max_iteracion,temp_max)
g.add_vertex_g(0,[-1,16,12,15],[false,false,false,false])
g.add_vertex_g(1,[22,-1,15,14],[false,false,false,false])
g.add_vertex_g(2,[14,15,-1,25],[false,false,false,false])
g.add_vertex_g(3,[4,5,8,-1],[false,false,false,false])

puts g.grafo.get_all_vertex
puts g.sa_algorithm
