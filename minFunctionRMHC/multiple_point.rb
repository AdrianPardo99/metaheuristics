#!/usr/bin/env ruby
require "./point.rb"

class Multiple_point
  attr_accessor :list_points
  def initialize(list_points=[])
    @list_points=list_points
  end
  
  def to_s
    str="("
    @list_points.each{|i|
      str+="#{i.to_s},"
    }
    str=str[0..(str.length-2)]
    str+=")"
    str
  end
end

mul=Multiple_point.new([Point.new(0),Point.new(1),Point.new(0)])
puts mul.to_s
