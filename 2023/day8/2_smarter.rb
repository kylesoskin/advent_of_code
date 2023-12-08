FILE = 'input.txt'
# FILE = 'sample3.txt'
data = File.readlines(FILE).map(&:chomp)
lrs = data.shift.chars
data.shift

mapped = data.map {|d| 
  s = d.split(?=)
  l, r = s.last.split(?,).map{|x| x.delete('()')}
  key = s.first.delete(' ')
  [key, {"L" => l.delete(' '), "R" => r.delete(' ')}]
}.to_h

def create_enum(x, lrs, mapped)
  Enumerator.new do |y|
    moves = 0
    lrs.cycle.each do |direction|
      moves += 1
      x[:next_dest] = mapped[x[:curr_pos]][direction]
      x[:curr_pos] = x[:next_dest] 
      y.yield [moves, x[:next_dest]] if x[:next_dest].end_with?(?Z)
    end
  end
end

all_current_pos = mapped.select {|k,v| k.end_with?(?Z)}.keys.map {|k| {curr_pos: k, next_dest: nil, moves: 0}}

enums = all_current_pos.map {|k| create_enum(k, lrs, mapped)}
all_results = enums.map {|e| e.next}
until all_results.all? {|x| x.last.end_with?(?Z)}
  all_results = enums.map {|e| e.next}
end
pp all_results.map(&:first).reduce(1) { |acc, n| acc.lcm(n) }
