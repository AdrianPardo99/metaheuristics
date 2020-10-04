/* Caso en el que el nodo tiene 2 vertices */
nodeActual=Set_of_nodes[random]
steps=M
N=0
setOfPaths={}
Path=[]
while(N<steps){

  if(value(nodeIzq(nodeActual))>value(nodeActual) || value(nodeDer(nodeActual))>value(nodeActual)){
    /* En esta parte puede eliminarse esta seccion con hacer uso de un
     * nuevo proceso en el cual mute a dos caminos distintos en memoria
     * y reduccion en tiempo */
    if(value(nodeIzq(nodeActual))>value(nodeActual)){
      Path.push(nodeActual)
      nodeActual=nodeIzq(nodeActual)
    }else{
      Path.push(nodeActual)
      nodeActual=nodeDer(nodeActual)
    }
    N++
  }else{
    setOfPaths.add(Path)
    Path=[]
    nodeActual=Set_of_nodes[random]
    N++
  }
}
show(Path)
