#!/usr/bin/env ruby
class Heuristicas
  def initialize()
    var=""
  end

  def n_to_b_s(num)
    str=[]
    if num==0
      return [0]
    end
    while num>0
      if num%2==0
        str.unshift(0)
      else
        str.unshift(1)
      end
      num/=2
    end
    str
  end

  def random_string(lista)
    rand(lista.length)
  end

  def get_locus(cadena)
    rand(cadena-1)
  end

  def evolution(locus,cadena)
    rand(locus..cadena)
  end

end
