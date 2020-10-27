#!/usr/bin/env ruby
require "./objeto.rb"
class Mochila
  attr_accessor :lista_objetos,:peso_max
  def initialize(lista_objetos=[],peso_max=0)
    @lista_objetos=lista_objetos
    @peso_max=peso_max
  end

  def add_elemento(peso,beneficio)
    @lista_objetos.push(Objeto.new(peso,beneficio))
  end

  def get_all_beneficio()
    ben=0
    @lista_objetos.each{|i|
      if i.selected
        ben+=i.beneficio
      end
    }
    ben
  end

  def get_all_peso()
    peso=0
    @lista_objetos.each{|i|
      if i.selected
        peso+=i.peso
      end
    }
    peso
  end

  def to_s_all()
    str=""
    @lista_objetos.each_with_index{ |v,i|
      str+="Objeto #{i+1}: #{v.to_s}\n"
    }
    str
  end

  def to_s()
    str=""
    @lista_objetos.each_with_index{|v,i|
      if v.selected
        str+="Objeto #{i+1}: #{v.to_s}\n"
      end
    }
    str
  end
end
