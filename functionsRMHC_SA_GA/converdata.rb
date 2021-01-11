#!/usr/bin/env ruby

func=["=MIN($","=MAX($","=PROMEDIO($","=MEDIANA($","=DESVESTPA($"]
campos_hoja=["GA_Gen."]
camp_h=[ "N23:N42)","N65:N84)","N107:N126)","N149:N168)",
  "N191:N210)","N233:N252)"]
str=""
campos_hoja.each{|j|
  camp_h.each{|i|
    str=""
    func.each{|k|
      str+="#{k}#{j}#{i}\t"
    }
    puts "#{str.chomp()}"
  }
  puts ""
}
