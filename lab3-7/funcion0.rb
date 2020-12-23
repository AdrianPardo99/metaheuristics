# Recibe indice de cual funcion trabajara
def get_eval(array=[],index=0)
  if index==0
    return evaluar_alpine(array)
  elsif index==1
    return evaluar_dixon(array)
  elsif index==2
    return evaluar_quintic(array)
  elsif index==3
    return evaluar_schwefel(array)
  elsif index==4
    return evaluar_streched(array)
  elsif index==5
    return evaluar_sum_squares(array)
  else
    return 2**1000
  end
end
