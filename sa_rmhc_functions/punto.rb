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

  def evaluar(index)
    if index==0
      return evaluar_alpine
    elsif index==1
      return evaluar_dixon
    elsif index==2
      return evaluar_quintic
    elsif index==3
      return evaluar_schwefel
    elsif index==4
      return evaluar_streched
    elsif index==5
      return evaluar_sum_squares
    else
      return 0
    end
  end

  def evaluar_alpine()
    func=0
    @lista_xi.each{|i|
      func+= (i*Math.sin(i)+0.1*i).abs
    }
    func
  end

  def evaluar_dixon()
    func=(@lista_xi[0]-1)**2
    for i in 1..(@dimension-1)
      func+=(i+1)*((2*Math.sin(@lista_xi[i])-@lista_xi[i-1])**2)
    end
    func
  end

  def evaluar_quintic()
    func=0
    @lista_xi.each{|i|
      func+=((i**5)-3*(i**4)+4*(i**3)-2*(i**2)-10*i-4).abs
    }
    func
  end

  def evaluar_schwefel()
    func=0
    @lista_xi.each{|i|
      func+=i**10
    }
    func
  end

  def evaluar_streched()
    func=0
    for i in 0..(@dimension-2)
      func+=(((@lista_xi[i+1]**2)+(@lista_xi[i]**2))**0.25)*((Math.sin(50*((@lista_xi[i+1]**2)+(@lista_xi[i]**2))**0.1))**2+0.1)
    end
    func
  end

  def evaluar_sum_squares()
    func=0
    @lista_xi.each_with_index{|i,j|
      func+= (j+1)*(i**2)
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
