p File.read('input.txt').lines.map {|l|
  h1, h2 = (ll=l.chomp).chars.each_slice(ll.size / 2).to_a
  Hash[ ((?a..?z).to_a.concat((?A..?Z).to_a)).zip((1..))][h1.find {|c| h2.include?(c)}]
}.sum