#!/usr/bin/env ruby
class Mochila_objeto
  attr_accessor :peso,:beneficio
  def initialize(peso=0,beneficio=0)
    @peso=peso
    @beneficio=beneficio
  end

  def to_s()
    "Peso: #{@peso}, Beneficio #{@beneficio}"
  end
end
