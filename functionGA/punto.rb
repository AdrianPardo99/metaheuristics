#!/usr/bin/env ruby
class Punto
  attr_accessor :dimension
  def initialize(dimension=1)
    @dimension=dimension
  end

  def get_eval(array=[])
    sum=0
    array.each{|i|sum+=i**2}
    sum
  end

  def set_points(array=[])
    if !array.empty?
      @dimension.times{|i|array[i]=rand(-10.0..10.0)}
    else
      @dimension.times{|i|array.push(rand(-10.0..10.0))}
    end
  end

  def get_coord(array=[])
    str="("
    array.each{|i|
      str+="#{sprintf("%.2f",i)},"
    }
    str=str[0..(str.length-2)]
    str+=")"
    str
  end
end
