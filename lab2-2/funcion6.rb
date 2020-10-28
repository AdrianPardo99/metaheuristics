def evaluar_sum_squares()
  func=0
  @lista_xi.each_with_index{|i,j|
    func+= (j+1)*(i**2)
  }
  func
end
