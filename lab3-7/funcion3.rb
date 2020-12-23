def evaluar_quintic(array=[])
  func=0
  array.each{|i|
    func+=((i**5)-3*(i**4)+4*(i**3)-2*(i**2)-10*i-4).abs
  }
  func
end
