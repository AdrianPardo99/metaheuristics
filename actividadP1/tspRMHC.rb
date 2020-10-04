cities={(i,[j,c])_0,(i,[j,c])_1,...,(i,[j,c])_n}
# Conjunto de ciudades donde
# => i es el indice del grafo (ciudad)
#     donde entre parentesis son
# => => j es el indice del siguiente grafo (ciudad)
# => => c es el costo de trasladarse de i a j
i_city=cities[random%cities.lenght]
path=[i_city]
lim_iterator=M
iterator=0
all_cities=cities.lenght-1
c_cities=0
use_index=[]
stuck_city=false
while (c_cities<all_cities || iterator<lim_iterator) && !stuck_city do
  vecino=i_city.get_vecinos()
  index=random%vecino.lenght
  if index not in use_index && use_index.lenght<vecino.lenght-1
    # Verifica si el indice no es repetitivo con respecto al arreglo
    #  y verifica si la ciudad a viajar no rebasa el limite, en cualquier caso
    #  esto genera que el viajero se quedo atascado ya viajo a todas
    #  las ciudades j

    use_index.push(index)
    city=vecino[use_index.last].city
    if city not in path
      # Verifica si la ciudad no esta en el camino del viajero
      i_city=city
      path.push(city)
      c_cities=c_cities+1
      use_index=[]
    end
  else
    stuck_city=true
  end
  iterator=iterator+1
end
showPath(path)
# Muestra el camino recorrido del viajero
# y a su vez muestra el costo total en el cual se desea sea poco
