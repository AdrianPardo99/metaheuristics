#!/usr/bin/env ruby
require "./point.rb"

class Nodes
  attr_accessor :list_points,:index
  def initialize(list_points=[],index=0)
    @list_points=list_points
    @index=index
  end

  def add_point(point)
    @list_points.push(Point.new(point[0],point[1]))
  end

  def set_point_by_index(indice)
    @list_points[indice].selected=true
  end

  def to_s_selected()
    str="Nodo #{@index}\t"
    @list_points.each{|i|
      if i.selected
        str+="#{i.to_s}\n"
      end
    }
    str
  end

  def deselected()
    @list_points.each{|i|
      i.selected=false
    }
  end

  def ret_selected_cost()
    cost=0
    @list_points.each{|i|
      if i.selected
        cost=i.cost
      end
    }
    cost
  end

  def to_s()
    str="Nodo #{@index}\n"
    @list_points.each{|i|
      str+="\t#{i.to_s}\n"
    }
    str
  end
end
