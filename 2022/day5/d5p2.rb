lines       = File.read('input.txt').lines.map(&:chomp)

diagram_txt = lines.shift(10)
diagram_txt.pop

stack_nums = diagram_txt.last.chars
index_of_stacks = (1..9).map{|n| [n,stack_nums.find_index(n.to_s)]}.to_h
diagram_txt.pop

struct = {}
diagram_txt.each do |line|
  index_of_stacks.each do |k,i|
    struct[k] ||= []
    struct[k] << line[i] 
  end
end
struct = struct.map {|k,v| [k, v.reject{|c| c == " "}]}.to_h

moves = lines.map {|l| 
  split = l.split(' ')
  [split[1],split[3],split[5]]
}

moves.each do |move|
  count, from, to = move.map(&:to_i)
  to_move = struct[from].shift(count)
  struct[to].unshift(to_move)
  struct[to].flatten!
end

pp struct.values.map(&:first).join