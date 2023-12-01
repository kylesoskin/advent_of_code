DIGITS = {
  one: 1,
  two: 2,
  three: 3,
  four: 4, 
  five: 5, 
  six: 6, 
  seven: 7, 
  eight: 8, 
  nine: 9
}.map {|k,v| [k.to_s, v.to_s]}.to_h

p File.read('input.txt').lines.map{|l|l.scan(/\d|zero|one|two|three|four|five|six|seven|eight|nine/).values_at(0,-1).map{|v|(DIGITS[v]||v)}.join.to_i}.sum