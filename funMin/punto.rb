#!/usr/bin/env ruby
class Punto
  attr_accessor :lista_xi,:dimension
  def initialize(dimension=1)
    @dimension=dimension
    @lista_xi=Array.new(@dimension)
  end

  def asigna_all()
    @lista_xi.each_with_index{|i,j|
      @lista_xi[j]=rand(-10.0..10.0)
    }
  end

  def asigna_p(index)
    @lista_xi[index]=rand(-10.0..10.0)
  end

  def evaluar()
    func=0
    @lista_xi.each{|i|
      func+= i**2
    }
    func
  end

  def to_s()
    str="("
    @lista_xi.each{|i|
      str+="#{sprintf('%.2f',i)},"
    }
    str=str[0..(str.length-2)]
    str+=")"
    str
  end
end
