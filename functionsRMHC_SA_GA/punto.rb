#!/usr/bin/env ruby
class Punto
  attr_accessor :dimension
  def initialize(dimension=1)
    @dimension=dimension
  end

  def get_eval(array=[],index=0)
    if index==0
      return evaluar_alpine(array)
    elsif index==1
      return evaluar_dixon(array)
    elsif index==2
      return evaluar_quintic(array)
    elsif index==3
      return evaluar_schwefel(array)
    elsif index==4
      return evaluar_streched(array)
    elsif index==5
      return evaluar_sum_squares(array)
    else
      return 2**1000
    end
  end

  def evaluar_alpine(array=[])
    func=0
    array.each{|i|
      func+= (i*Math.sin(i)+0.1*i).abs
    }
    func
  end

  def evaluar_dixon(array=[])
    func=(array[0]-1)**2
    (@dimension-1).times{|i|
      func+=(i+1)*((2*Math.sin(array[i])-array[i-1])**2)
    }
    func
  end

  def evaluar_quintic(array=[])
    func=0
    array.each{|i|
      func+=((i**5)-3*(i**4)+4*(i**3)-2*(i**2)-10*i-4).abs
    }
    func
  end

  def evaluar_schwefel(array=[])
    func=0
    array.each{|i|
      func+=i**10
    }
    func
  end

  def evaluar_streched(array=[])
    func=0
    (@dimension-2).times{|i|
      func+=(((array[i+1]**2)+(array[i]**2))**0.25)*((Math.sin(50*((array[i+1]**2)+(array[i]**2))**0.1))**2+0.1)
    }
    func
  end

  def evaluar_sum_squares(array=[])
    func=0
    array.each_with_index{|i,j|
      func+= (j+1)*(i**2)
    }
    func
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
