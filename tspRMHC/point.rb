#!/usr/bin/env ruby

class Point
  attr_accessor :cost,:go_to,:selected
  def initialize(cost=0,go_to=0,selected=false)
    @cost=cost
    @go_to=go_to
    @selected=selected
  end

  def to_s()
    if selected
      "con vertice a #{@go_to} con costo #{@cost} [✓]"
    else
      "con vertice a #{@go_to} con costo #{@cost} [ ]"
    end
  end
end
