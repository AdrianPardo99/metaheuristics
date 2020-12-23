#!/usr/bin/env ruby

func=["=MIN($","=MAX($","=PROMEDIO($","=MEDIANA($","=DESVESTPA($"]
campos_hoja=["Alpine_Stacionary.","Dixon_Gen.",
  "Quintic_Stacionary.","Schwefel_Gen.","Streched_Stacionary.",
  "Sum_Squares_Gen."]
camp_h=["C2:C21)","B2:B21)","C22:C41)","B22:B41)"]
str=""
camp_h.each{|i|
  campos_hoja.each{|j|
    str=""
    func.each{|k|
      str+="#{k}#{j}#{i}\t"
    }
    puts "#{str.chomp()}"
  }
}
