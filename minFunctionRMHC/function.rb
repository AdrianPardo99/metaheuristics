#!/usr/bin/env ruby
require "./multiple_point"
class Function
  attr_accessor :lista_puntos, :dimension
  def initialize(lista_puntos=[],dimension=1)
    @lista_puntos=lista_puntos
    @dimension=dimension
  end

  def add_points(point)
    @lista_puntos.push(Multiple_point.new(point))
  end

  def to_s()
    str=""
    @lista_puntos.each{|i|
      str+="#{i.to_s}\n"
    }
    str
  end
end
