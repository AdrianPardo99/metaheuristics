#!/usr/bin/env ruby

class TSP
  attr_accessor :table_cost
  def initialize(table_cost=[[]])
    @table_cost=table_cost
  end

  def calculate_cost(array)
    costo=0
    array.each_with_index{|i,j|
      costo+=@table_cost[j][i]
    }
    costo
  end
  def marca_trayecto(array)
    str=""
    array.each_with_index{|i,j|
      str+="\tNodo #{j} -> Nodo #{i}\n"
    }
    str
  end

end
