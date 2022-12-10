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

display = Array.new(240,?.)
cycles.each do |c,x|
  p = x+1
  sprite = [p-1,p,p+1]
  hp = c % 40
  display[c-1] = '#' if sprite.include?(hp)
end

puts display.each_slice(40).map(&:join)