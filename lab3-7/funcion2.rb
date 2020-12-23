def evaluar_dixon(array=[])
  func=(array[0]-1)**2
  (@dimension-1).times{|i|
    func+=(i+1)*((2*Math.sin(array[i])-array[i-1])**2)
  }
  func
end
