# FILE = 'input.txt'
FILE = 'sample3.txt'
data = File.readlines(FILE).map(&:chomp)
lrs = data.shift.chars
data.shift

mapped = data.map {|d| 
  s = d.split(?=)
  l, r = s.last.split(?,).map{|x| x.delete('()')}
  key = s.first.delete(' ')
  [key, {"L" => l.delete(' '), "R" => r.delete(' ')}]
}.to_h

all_current_pos = mapped.select {|k,v| k.end_with?(?Z)}.keys
all_current_pos = all_current_pos.map {|k| {curr_pos: k, next_dest: nil, moves: 0}}

moves = 0
gnd = nil



lrs.cycle.each do |direction|
  moves += 1
  all_current_pos.each do |x|    
    x[:next_dest] = mapped[x[:curr_pos]][direction]
    gnd = x[:next_dest]
    x[:curr_pos] = x[:next_dest] 
  end
  break if gnd.end_with?(?Z) && all_current_pos.all?{|x| x[:next_dest].end_with?(?Z)} 
end

# pp [all_current_pos, moves]
pp moves