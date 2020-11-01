#!/usr/bin/env ruby

func=["Alpine'!", "Dixon'!", "Quintic'!", "Schwefel'!", "Strechced'!", "SumSquare'!"]

op=["=MIN('SA ","=MAX('SA ","=PROMEDIO('SA ","=MEDIANA('SA ","=STDEV.S('SA "]
val=["F22:F41)"]

op.each{|op|
  func.each{|func|
    val.each{|v|
      print "#{op}#{func}#{v}"
    }
    puts "\n"
  }
}
