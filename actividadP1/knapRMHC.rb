knapsack_max_peso=S
objects={(p,b)_0,(p,b)_1,...,(p,b)_n}
# Conjunto de datos donde
# => p es el peso del objeto
# => b es el beneficio del objeto
sol_i=[].push(objects[random%objects.lenght])
lim_iterator=M
iterator=0
while iterator<lim_iterator || get_best_solution(sol_i) do
  # get_best_solution es una funcion en la cual aproxima a un valor
  #  numerico R el cual tiene un rango para decir que la solucion
  #  es la mejor que puede dar el programa
  obj=objects[random%objects.lenght]
  if obj not in sol_i
    # Verifica si el objeto que fue iterado esta o no esta en la lista
    #  de objetos de la mochila para verificar si pueden ser agregados
    if obj.p+sol_i.sumP()<=knapsack_max_peso
      # Verifica si la suma de los pesos del objeto y del contenido
      #  de la mochila no rebasa el peso maximo  de la mochila para
      #  ser agregado
      sol_i.push(obj)
    end
  end
  iterator=iterator+1
end
show(sol_i)
# Muestra la solucion obtenida por el programa el cual busca maximizar
# la utilidad/beneficio de la mochila
