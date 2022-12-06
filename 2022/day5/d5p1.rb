BLANK       = ' '
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
    v = line[i]
    struct[k] <<  v unless v == BLANK
  end
end

lines.each do |m|
  split = m.split(BLANK)
  count, from, to = [split[1],split[3],split[5]].map(&:to_i)
  count.times do 
    to_move = struct[from].shift
    struct[to].unshift(to_move)
  end
end
p struct.values.map(&:first).join