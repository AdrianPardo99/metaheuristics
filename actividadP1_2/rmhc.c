
1.- best_evaluated=random(String) /* Selecciona una cadena aleatoria */
i=0
3.-while(i<number_evaluated_lim){ /* Vuelve a paso 2 */
  2.- locus=random(best_evaluated) /* Mutacion random para locus que va de 0 a best_evaluated-1 */
  new_evaluated=mutation(best_evaluated,locus)
  if fitness(best_evaluated)<=fitness(new_evaluated)
    best_evaluated=new_evaluated
  i++
}
4.- return best_evaluated /* Retorna la cadena aleatoria mejor evaluada*/
