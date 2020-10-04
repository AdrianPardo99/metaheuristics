t_dim=D>=1
espace=[]
p=[0,0,...,0]
# p es el punto de t_dim dimensiones el cual contendra los puntos
#  al menos en 0
espace.push(p)
lim_iterator=M
iterator=0
num_minimos=1
while iterator<lim_iterator || get_num_esperado_minimos(num_minimos) do
  # get_num_esperado_minimos es una funcion la cual establece un
  #  numero determinado de minimos ya que la funcion en D dimensiones
  #  es muy dificil de explorar
  xj_select=random%t_dim
  for i=0;i<t_dim;i++
    # Genera cualquier combinacion de puntos de [-10,10] para cada xi
    p[i]=random%10
    p[i]=(random%2==0)?(p[i]):(-p[i])
  end
  # Como bien sabemos es una funcion cuadratica en cada valor
  #  xi independiente por lo tanto solo es necesario modificar
  #  xj ya que ahi es donde existe el valor minimo de esa variables
  p[xj_select]=0
  if p not in espace
    # Verifica si el punto de D dimensiones no existe en el espacio
    #  de soluciones propuesto para evitar redudancia de datos
    espace.push(p)
    num_minimos=num_minimos+1
  end
  iterator=iterator+1

end
show_points(espace)
