def evaluar_dixon()
  func=(@lista_xi[0]-1)**2
  for i in 1..(@dimension-1)
    func+=(i+1)*((2*Math.sin(@lista_xi[i])-@lista_xi[i-1])**2)
  end
  func
end
