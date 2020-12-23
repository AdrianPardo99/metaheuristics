def evaluar_schwefel(array=[])
  func=0
  array.each{|i|
    func+=i**10
  }
  func
end
