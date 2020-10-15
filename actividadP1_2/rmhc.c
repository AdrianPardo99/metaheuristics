
1.- best_evaluated=random(String) /* Selecciona una cadena aleatoria */
/* Ejemplo una cadena de bits
    5 productos ()
    10100 -> Verificar que sea valia con respecto al peso maximo
  1.1 Calcular f_best <- Calculo de beneficio


*/
i=0
3.-while(i<number_evaluated_lim){ /* Vuelve a paso 2 */
  2.- locus=random(best_evaluated) /* Mutacion random para locus que va de 0 a best_evaluated-1 escoger 1 bit */
  new_evaluated=mutation(best_evaluated,locus) /* si x cambia a ~x*/
  /* Verifico si new_evaluated es valido */
  if fitness(best_evaluated)<=fitness(new_evaluated)
    best_evaluated=new_evaluated
  i++
}
4.- return best_evaluated /* Retorna la cadena aleatoria mejor evaluada*/
