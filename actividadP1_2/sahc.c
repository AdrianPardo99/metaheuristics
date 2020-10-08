1- current_hiltop=rand(String) /* Selecciona una cadena aleatoria */
i=0
boolFound=false
2.- while i<mutationTotal(current_hiltop) && !boolFound{
  c1=mutation(current_hiltop,i) /* Muta de izquierda a deracha cada bit de la cadena */
  3.-if fitness(current_hiltop)<fitness(c1){ /* Verifica cual de las dos cadenas tiene mejor valor*/
    current_hiltop=c1
    boolFound=true
  }
  i++;
}
4.- if(boolFound){ /* Verifica si existe un mejor fitness y si es asi va al paso 2*/
  goto 2
}else{ /* En caso contrario guarda la cadena y regresa a 1 */
  save(current_hiltop)
  goto 1
}
5.- return save /* Retorna la solucion */
