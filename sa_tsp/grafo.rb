#!/usr/bin/env ruby
require "./vertice.rb"
class Grafo
  attr_accessor :vertices
  def initialize(vertices=[])
    @vertices=vertices
    @repetido=[]
  end

  def get_costo_t()
    costo=0
    @vertices.each{|i|
      costo+=i.get_costo_vertex
    }
    costo
  end

  def get_all_vertex()
    str=""
    @vertices.each{|i|
      str+=i.to_s_all
    }
    str
  end

  def to_s()
    str=""
    @vertices.each{|i|
      str+="#{i.to_s}\n"
    }
    str
  end

  def genera_sol_aleatoria()
    @repetido.clear()
    for i in 0..(@vertices.length-1)
      arista=0
      loop{
        arista=rand(@vertices[i].go_to.length)
        if(arista!=i)
          if(!@repetido.include?arista)
            @repetido.push(arista)
            break
          end
        end
      }
      @vertices[i].go_to[arista]=!@vertices[i].go_to[arista]
    end
  end

  def verifica_vertices()
    @vertices.each_with_index{|i,j|
      if @vertices[j].go_to[j]
        return false
      end
    }
    return true
  end

  def permuta(j=0)
    loop{
      for i in 0..j
        cabeza=@repetido[0]
        @repetido.delete_at(0)
        @repetido.push(cabeza)
      end
      @vertices.each{|i|
        i.go_to_false_all()
      }
      @repetido.each_with_index{|i,k|
        @vertices[k].go_to[i]=true
      }
      # Verifica que los vertices a analizar no esten en el mismo indice
      if verifica_vertices()
        break
      end
    }
  end

  def add_vertex(index,costo,go_to)
    @vertices.push(Vertice.new(index,costo,go_to))
  end
end
