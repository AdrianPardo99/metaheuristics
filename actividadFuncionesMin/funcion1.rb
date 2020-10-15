def evaluar_alpine()
  func=0
  @lista_xi.each{|i|
    func+= (i*Math.sin(i)+0.1*i).abs
  }
  func
end
