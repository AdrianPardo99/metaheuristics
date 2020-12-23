def evaluar_streched(array=[])
  func=0
  (@dimension-2).times{|i|
    func+=(((array[i+1]**2)+(array[i]**2))**0.25)*((Math.sin(50*((array[i+1]**2)+(array[i]**2))**0.1))**2+0.1)
  }
  func
end
