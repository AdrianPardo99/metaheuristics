def evaluar_schwefel()
  func=0
  @lista_xi.each{|i|
    func+=i**10
  }
  func
end
