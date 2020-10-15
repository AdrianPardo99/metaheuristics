#!/usr/bin/env ruby
require "./rmhc_class.rb"
require "./fileLoader.rb"


puts "Hola bienvenido al Knapsack Problem"
peso=10
max_iteration=100
puts "Deseas modificar el peso por defecto que tiene el problema?\n\t"+
      "Actualmente el peso maximo es #{peso}"
peso=gets.chomp.to_i
puts "Deseas modificar el maximo numero de iteraciones que tiene el problema?\n\t"+
      "Actualmente el programa cuenta con un limite de iteraciones de #{max_iteration}"
max_iteration=gets.chomp.to_i
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


rmhc=Rmhc_class.new(Mochila.new(peso),max_iteration)
data.each{|j|
  rmhc.new_object(j.split(",").map(&:to_i))
}
rmhc.object_in_old_knapsack(3)
rmhc.object_in_old_knapsack(4)
repit=1
while repit>0
  Gem.win_platform? ? (system "cls") : (system "clear")
  rmhc.print_mochila_old_desc
  print "Presiona Enter para presentar la nueva solución..."
  gets
  rmhc.algorithm
  rmhc.print_mochila_new_desc
  puts "Deseas realizar un swap con respecto a la nueva solucion y la vieja? "+
        "(1=si/2=no)"
  resp=gets.chomp.to_i
  if resp==1
    rmhc.swap
  end
  puts "Deseas buscar una nueva solucion con los nuevos parametros (1=si/0=no)"
  repit=gets.chomp.to_i
end
