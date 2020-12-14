#!/usr/bin/env ruby
require "./objeto.rb"
class Mochila
  attr_accessor :peso_max,:objetos
  def initialize(peso_max=0,objetos=[])
    @peso_max=peso_max
    @objetos=objetos
  end

  def add_elemento(peso=0,beneficio=0)
    @objetos.push(Objeto.new(peso,beneficio))
  end

  def get_objetos()
    str=""
    @objetos.each{|i|
      str+="[ ] "+i.to_s+"\n"
    }
    str
  end

  def get_beneficio(array=[])
    ben=0
    array.length.times{|i|
      ben+=array[i]*@objetos[i].beneficio
    }
    ben
  end

  def get_peso(array=[])
    peso=0
    array.length.times{|i|
      peso+=array[i]*@objetos[i].peso
    }
    peso
  end

  def get_selected_sol(array)
    str=""
    array.length.times{|i|
      if array[i]==1
        str+="\t[✓] "+@objetos[i].to_s+"\n"
      end
    }
    str
  end
end
#m=Mochila.new(15)
#m.add_elemento(3,10)
#m.add_elemento(4,4)
#m.add_elemento(5,11)
#puts m.get_objetos
#arr=[0,1,0]
#puts "Solucion #{arr.to_s}\n#{m.get_selected_sol(arr)}"
