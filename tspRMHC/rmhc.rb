#!/usr/bin/env ruby
require "./nodes.rb"
require "./heuristica"
class Rmhc
  attr_accessor :list_nodes_old,:list_nodes_new,:e,:camino_old,:camino_new
  def initialize(list_nodes_old=[],e=0)
    @list_nodes_old=list_nodes_old
    @e=e
    @list_nodes_new=[]
    @list_nodes_old.each{|i|@list_nodes_new.push(i)}
    @evolution=Heuristica.new
    @camino_new=[]
    @camino_old=[]
    @new_visitados=[]
  end
  def add_node_by_index_vextex(index,node)
    @list_nodes_old[index].add_point(node)
    @list_nodes_new[index].add_point(node)
  end

  def add_new_vextex(index)
    @list_nodes_old.push(Nodes.new([],index))
    @list_nodes_new.push(Nodes.new([],index))
  end

  def set_vertex_true(lista,index,vertex,type)
    lista[index].set_point_by_index(vertex)
    if type==0
      @camino_old.push("#{lista[index].index}->#{lista[index].list_points[vertex].go_to}")
    else
      @camino_new.push("#{lista[index].index}->#{lista[index].list_points[vertex].go_to}")
      @new_visitados.push(lista[index].index)
    end
  end

  def old_to_s()
    str=""
    @list_nodes_old.each{|i|
      str+=i.to_s
    }
    str
  end

  def new_to_s()
    str=""
    @list_nodes_new.each{|i|
      str+=i.to_s
    }
    str
  end

  def get_all_cost_selected(lista)
    cost=0
    lista.each{|i|
      cost+=i.ret_selected_cost
    }
    "Costo total por el rerrido #{cost}"
  end

  def show_path(type)
    str="\nFormato (nodo_origen->nodo_destino):\n\t"
    if(type==0)
      @camino_old.each{|i|
        str+="#{i}\t"
      }
    else
      @camino_new.each{|i|
        str+="#{i}\t"
      }
    end
    str
  end

  def algRMHC()
    j=0
    first_include=false
    first_node=rand(@list_nodes_old.length-1)
    while j<@e
      best_solution=rand(1..@list_nodes_old[first_node].list_points.length-1)
      f_best=@list_nodes_old[first_node].list_points[best_solution].cost
      i=0
      while i<@e
        locus=@evolution.get_locus(best_solution)
        new_best=@evolution.mutacion(best_solution,locus)
        f_new=@list_nodes_old[first_node].list_points[new_best].cost
        next_node=@list_nodes_old[first_node].list_points[new_best].go_to
        if f_new<=f_best
          if !@list_nodes_new[first_node].list_points[new_best].selected
            set_vertex_true(@list_nodes_new,first_node,new_best,1)
            first_node=next_node
            best_solution=new_best
            f_best=f_new
            if best_solution==0
              best_solution=rand(1..@list_nodes_old[first_node].list_points.length-1)
              f_best=@list_nodes_old[first_node].list_points[best_solution].cost
            end
          end
        end
        i+=1
      end
      if get_all_cost_selected(@list_nodes_new)<=get_all_cost_selected(@list_nodes_old)
        break
      else
        @camino_new.clear()
        @list_nodes_new.each{|i|
          i.deselected()
        }
      end
      j=j+1
    end
  end
end

algoritm=Rmhc.new([],100)
algoritm.add_new_vextex(0)
algoritm.add_node_by_index_vextex(0,[3,2])
algoritm.add_node_by_index_vextex(0,[3,4])
algoritm.add_node_by_index_vextex(0,[4,1])
algoritm.add_node_by_index_vextex(0,[4,3])
algoritm.add_new_vextex(1)
algoritm.add_node_by_index_vextex(1,[2,0])
algoritm.add_node_by_index_vextex(1,[3,2])
algoritm.add_node_by_index_vextex(1,[4,3])
algoritm.add_node_by_index_vextex(1,[2,4])
algoritm.add_new_vextex(2)
algoritm.add_node_by_index_vextex(2,[2,0])
algoritm.add_node_by_index_vextex(2,[3,3])
algoritm.add_node_by_index_vextex(2,[4,1])
algoritm.add_node_by_index_vextex(2,[2,4])
algoritm.add_new_vextex(3)
algoritm.add_node_by_index_vextex(3,[2,4])
algoritm.add_node_by_index_vextex(3,[3,0])
algoritm.add_node_by_index_vextex(3,[4,1])
algoritm.add_node_by_index_vextex(3,[2,2])
algoritm.add_new_vextex(4)
algoritm.add_node_by_index_vextex(4,[2,0])
algoritm.add_node_by_index_vextex(4,[3,1])
algoritm.add_node_by_index_vextex(4,[4,2])
algoritm.add_node_by_index_vextex(4,[2,3])
algoritm.set_vertex_true(algoritm.list_nodes_old,0,2,0)
algoritm.set_vertex_true(algoritm.list_nodes_old,1,2,0)
algoritm.set_vertex_true(algoritm.list_nodes_old,3,3,0)
algoritm.set_vertex_true(algoritm.list_nodes_old,4,0,0)

Gem.win_platform? ? (system "cls") : (system "clear")
puts algoritm.old_to_s
puts algoritm.get_all_cost_selected(algoritm.list_nodes_old)
puts algoritm.show_path(0)
print "Presiona Enter para presentar la nueva solución..."
gets
algoritm.algRMHC
puts algoritm.new_to_s
puts algoritm.get_all_cost_selected(algoritm.list_nodes_new)
puts algoritm.show_path(1)
