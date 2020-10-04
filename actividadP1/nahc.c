/* Caso en el que el nodo tiene 2 vertices */
nodeActual=Set_of_nodes[random]
steps=M
N=0
setOfPaths={}
Path=[]
while(N<steps){
  if(value(nodeIzq(nodeActual))>value(nodeActual)){
    Path.push(nodeActual)
    nodeActual=nodeIzq(nodeActual)
    N++
  }else if(value(nodeDer(nodeActual))>value(nodeActual)){
    Path.push(nodeActual)
    nodeActual=nodeDer(nodeActual)
    N++
  }else{
    setOfPaths.add(Path)
    Path=[]
    nodeActual=Set_of_nodes[random]
    N++
  }
}
show(Path)
