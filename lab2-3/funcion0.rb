# Recibe indice de cual funcion trabajara
def evaluar(index)
  if index==0
    return evaluar_alpine
  elsif index==1
    return evaluar_dixon
  elsif index==2
    return evaluar_quintic
  elsif index==3
    return evaluar_schwefel
  elsif index==4
    return evaluar_streched
  elsif index==5
    return evaluar_sum_squares
  else
    return 0
  end
end
