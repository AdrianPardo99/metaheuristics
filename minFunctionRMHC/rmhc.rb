#!/usr/bin/env ruby
require "./function.rb"
require "./heuristica"
class Rmhc
  attr_accessor :old_func,:new_func,:e
  def initialize(old_func=Function.new,e=0)
    @old_func=old_func
    @new_func=new_func
    @e=e
    @evolution=Heuristica.new
  end
  # Falta más implementación pero idea ya esta
end

f=Function.new([],3)
f.add_points([1,2,0])
f.add_points([10,2,0])
f.add_points([-1,-2,0])
puts f.to_s
