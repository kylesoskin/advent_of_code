VALS = Hash[ ((?a..?z).to_a.concat((?A..?Z).to_a)).zip((1..))]
p File.read('input.txt').lines.each_slice(3).map{|g|
  x,y,z = g.map{|e| e.chomp.chars}
  VALS[x.find {|c| y.include?(c) && z.include?(c)}]
}.sum