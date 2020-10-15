def evaluar_quintic()
  func=0
  @lista_xi.each{|i|
    func+=((i**5)-3*(i**4)+4*(i**3)-2*(i**2)-10*i-4).abs
  }
  func
end
