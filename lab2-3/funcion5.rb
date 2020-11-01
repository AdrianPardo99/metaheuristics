def evaluar_streched()
  func=0
  for i in 0..(@dimension-2)
    func+=(((@lista_xi[i+1]**2)+(@lista_xi[i]**2))**0.25)*((Math.sin(50*((@lista_xi[i+1]**2)+(@lista_xi[i]**2))**0.1))**2+0.1)
  end
  func
end
