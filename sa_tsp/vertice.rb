#!/usr/bin/env ruby

class Vertice
  attr_accessor :index,:costo,:go_to
  def initialize(index=0,costo=[],go_to=[])
    @index=index
    @costo=costo
    @go_to=go_to
  end

  def go_to_false_all()
    @go_to.each_with_index{|i,j|
      @go_to[j]=false
    }
  end

  def to_s()
    str="Vertice #{@index}"
    @go_to.each_with_index{|i,j|
      if i
        str+=" a Vertice #{j} con costo #{@costo[j]}"
      end
    }
    str
  end

  def get_costo_vertex()
    costo_v=0
    @go_to.each_with_index{|i,j|
      if i
        costo_v=@costo[j]
      end
    }
    costo_v
  end

  def to_s_all()
    str="Vertice #{@index}\n\t"
    @go_to.each_with_index{|i,j|
      if j!=@index
        str+="a Vertice #{j} con costo #{@costo[j]}\n\t"
      end
    }
    str+="\n"
    str
  end

  def get_index_go_to()
    @go_to.each_with_index{|i,j|
      if i
        return j
      end
    }
    return -1
  end
end
