def evaluar_sum_squares(array=[])
  func=0
  array.each_with_index{|i,j|
    func+= (j+1)*(i**2)
  }
  func
end
