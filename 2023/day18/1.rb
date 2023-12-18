@data = File.readlines(
  'input.txt'
).map { |l| dir, count, color = l.chomp.split(' '); {dir:, count:, color:} }

@travel_path = [[]]

def walk_one(dir, y, x)
  pp [dir, y, x, @travel_path.size]
  if @travel_path[y].nil?
    (y+1 - @travel_path.size).times { @travel_path << []}
  end
  @travel_path[y][x] = ?#
  case dir
  when ?R
    x += 1
  when ?L
    x -= 1
  when ?U
    y -= 1
  when ?D
    y += 1
  end
  [y, x]
end

x, y = 0, 0
@data.each do |h|
  dir = h[:dir]
  h[:count].to_i.times do 
    y, x = walk_one(dir, y, x)
  end
end
pp @travel_path