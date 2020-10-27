#!/usr/bin/env ruby
class Objeto
  attr_accessor :peso,:beneficio,:selected
  def initialize(peso=0,beneficio=0,selected=false)
    @peso=peso
    @beneficio=beneficio
    @selected=selected
  end

  def to_s
    if @selected
      return "[✓] Peso #{@peso}, Beneficio #{@beneficio}"
    else
      return "[ ] Peso #{@peso}, Beneficio #{@beneficio}"
    end
  end
end
