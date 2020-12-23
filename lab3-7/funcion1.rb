def evaluar_alpine(array=[])
  func=0
  array.each{|i|
    func+= (i*Math.sin(i)+0.1*i).abs
  }
  func
end
