1- current_hiltop=rand(String) /* Selecciona una cadena aleatoria */
i=0
boolFound=false
2.- while i<mutationTotal(current_hiltop){ /* Muto la cadena */
  c1=mutation(current_hiltop,i)
  if fitness(current_hiltop)<fitness(c1){ /* Verifico cual de las dos cadenas tiene mejor fitness*/
    current_hiltop=c1
    boolFound=true
  }
  i++
}

3.- if boolFound{ /* Verifico si la colina que verifique inicialmente no encontro mejor fitness*/
  save(current_hiltop)
  goto 1
}

return save
