#!/usr/bin/env ruby
class Replacement
  attr_accessor :parent1,:parent2,:child1,:child2
  def initialize(parent1=[],parent2=[],child1=[],child2=[])
    @parent1=parent1
    @parent2=parent2
    @child1=child1
    @child2=child2
  end

  def elitism(minmax=0)
    """
      En este en el mejor de los casos es bueno que los arreglos sean los
      valores evaluados de cada uno de los padres o que al menos se pueda
      obtener el valor de la evaluacion fitness de cada elemento de los arreglos
    """
    #puts "Remplazo elitista mediante las funciones fitness"
    hash_min={}
    hash_min[:p1]=@parent1[0]
    hash_min[:p2]=@parent2[0]
    hash_min[:c1]=@child1[0]
    hash_min[:c2]=@child2[0]
    hash_min=hash_min.sort_by {|k, v| -v}
    arr_f1=[]
    arr_f2=[]
    if minmax==0
      #puts "Minimizacion"
      arr_f1=hash_min[-1]
      arr_f2=hash_min[-2]
    else
      #puts "Maximizacion"
      arr_f1=hash_min[0]
      arr_f2=hash_min[1]
    end
    #puts "Seleccionados #{arr_f1.to_s}, #{arr_f2.to_s}"
    return [arr_f1[0],arr_f2[0]]
  end

  def crowding(semejanza=0)
    """
      En este operador se verificar cuales elementos tienen mejor semejanza con
      respecto a los otros elementos es decir padres con padres y con hijos.
      Este algoritmo analiza elemento a elemento
    """
    hash={:p1p2=>0,:p1c1=>0,:p1c2=>0,:p2c1=>0,:p2c2=>0}
    @parent1.length.times{|i|
      if @parent1[i]==@parent2[i]
        hash[:p1p2]+=1
      end
      if @parent1[i]==@child1[i]
        hash[:p1c1]+=1
      end
      if @parent1[i]==@child2[i]
        hash[:p1c2]+=1
      end
      if @parent2[i]==@child2[i]
        hash[:p2c2]+=1
      end
    }
    hash=hash.sort_by{|k,v| -v}
    puts "Valores ordenados #{hash.to_s}"
    return semejanza==0?[hash[-1][0],hash[-2][0]]:[hash[0][0],hash[1][0]]
  end

  def torneo()
    """
      Se genera aleatoriamente un arreglo de orden para comparar si es
      semejante via indice y asi seleccionar a los cromosomas mas acercados a el
    """
    array=[]
    @parent1.length.times{|i|
      array.push(i)
    }
    array.length.times{|i|
      c=rand(array.length)
      c1=rand(array.length)
      # Permuta el arreglo para saber cual seleccionar
      v=array[c]
      array[c]=array[c1]
      array[c1]=v
    }
    puts "Arreglo generado #{array.to_s}"
    hash={:arrp1=>0,:arrp2=>0,:arrc1=>0,:arrc2=>0}
    @parent1.length.times{|i|
      if @parent1[i]==array[i]
        hash[:arrp1]+=1
      end
      if @parent2[i]==array[i]
        hash[:arrp2]+=1
      end
      if @child1[i]==array[i]
        hash[:arrc1]+=1
      end
      if @child2[i]==array[i]
        hash[:arrc2]+=1
      end
    }
    hash=hash.sort_by{|k,v| -v}
    puts "Tabla generada #{hash.to_s}"
    return [hash[0][0],hash[1][0]]
  end

end
