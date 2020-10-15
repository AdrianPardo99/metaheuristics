#!/usr/bin/env ruby
class Heuristica
  def initialize()
    var=""
  end

  def mutacion(cadena,locus)
    rand(locus...cadena)
  end

  def get_locus(cadena)
    rand(0..(cadena-1))
  end
end
