input = File.read('input.txt').lines.map(&:chomp)

def signal_strength(cycle, x)
  cycle * x
end

cycle_count = 0
x = 1
cycles = {}

input.each do |i|
  cmd = i.split(' ')
  if cmd.size == 1
    cycle_count += 1 
    cycles[cycle_count] = x
  else
    cycle_count += 1
    cycles[cycle_count] = x
    cycle_count += 1
    cycles[cycle_count] = x
    x += cmd.last.to_i
  end
end
index = 20
acc = 0
while index <= 220
  acc += signal_strength(index, cycles[index])
  index += 40
end
p acc