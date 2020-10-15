#!/usr/bin/env ruby
class Point
  attr_accessor :coordenada
  def initialize(coordenada=0)
    @coordenada=coordenada
  end

  def to_s()
    "#{@coordenada}"
  end
end
