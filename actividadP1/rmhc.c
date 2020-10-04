/* Caso en el que el nodo tiene 2 vertices */
nodeActual=Set_of_nodes[random]
steps=M
N=0
setOfPaths={}
Path=[]
while(N<steps){
  if(rand()%2==0){
    Path.push(nodeActual)
    nodeActual=nodeIzq(nodeActual)
    N++
  }else{
    Path.push(nodeActual)
    nodeActual=nodeDer(nodeActual)
    N++
  }
}
show(Path)
