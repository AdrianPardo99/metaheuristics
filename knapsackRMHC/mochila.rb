#!/usr/bin/env ruby
require "./mochila_objeto"
class Mochila
  attr_accessor :max_peso,:objetos,:in_knapsack
  def initialize(max_peso=0,objetos=[],in_knapsack=[])
    # @max_peso:    Maximo peso de la mochila
    # @objetos:     Array de objetos que pueden ir en la mochila
    # @in_knapsack: Array de la existencia de los objetos en la mochila
    @max_peso=max_peso
    @objetos=objetos
    @in_knapsack=in_knapsack
  end

  def get_peso_total()
    peso_total=0
    @objetos.each_index{|i|
      peso_total=peso_total+@objetos[i].peso
    }
    peso_total
  end

  def get_peso_in_knapsack()
    peso_in=0
    @objetos.each_index{|i|
      if @in_knapsack[i]
        peso_in=peso_in+@objetos[i].peso
      end
    }
    peso_in
  end

  def get_beneficio_in_knapsack()
    ben=0
    @objetos.each_index{|i|
      if @in_knapsack[i]
        ben=ben+@objetos[i].beneficio
      end
    }
    ben
  end

  def add_object(item_knapsack)
    @objetos.push(Mochila_objeto.new(item_knapsack[0],item_knapsack[1]))
    @in_knapsack.push(false)
  end

  def show_all_objects()
    @objetos.each_index{ |i|
      puts "[ ] Objeto #{i+1}: #{@objetos[i].to_s}"
    }
  end

  def show_in_knapsack()
    @objetos.each_index{|i|
      if @in_knapsack[i]
        puts "[✓] Objeto #{i+1}: #{@objetos[i].to_s}"
      end
    }
  end
end
