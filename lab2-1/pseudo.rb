
s<-Solucion_inicial
e_old<-funcion_fitness(s)
t<-temp_max
while t< temp_min
  # temp_min es aproximado a 0
  i=0
  while i<imax
    # imax puede ser representativo dependiendo del problema que se aborda
    #  o en todo caso puede ser el numero de iteraciones maxima
    seleccion_solucion_sucesor_de(s)
    # seleccion_solucion_sucesor_de es una funcion que explora la vecindad del arbol
    #    elige aleatoriamente
    e_new<-funcion_fitness(s)
    delta=e_new-e_old
    if delta>0
      if rand(0..1) >= exp(-delta/(K*temp))
        deshacer_sucesor(s)
      else
        e_old=e_new
      end
    else
      e_old=e_new
    end
    i+=1
  end
  t*=alpha
  # alpha es una constante que va al inicio del programa entre [0.88,0.99]
end
