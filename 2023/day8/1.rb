FILE = 'input.txt'
# FILE = 'sample2.txt'
data = File.readlines(FILE).map(&:chomp)
lrs = data.shift.chars
data.shift

mapped = data.map {|d| 
  s = d.split(?=)
  l, r = s.last.split(?,).map{|x| x.delete('()')}
  key = s.first.delete(' ')
  [key, {"L" => l.delete(' '), "R" => r.delete(' ')}]
}.to_h

curr_pos ="AAA"
moves = 0

lrs.cycle.each do |direction|
  pp "Currently at #{curr_pos}: #{mapped[curr_pos]}, moving #{direction}"
  moves += 1
  next_dest = mapped[curr_pos][direction]
  break if next_dest == "ZZZ"
  curr_pos = next_dest
end

puts "Total moves: #{moves}"