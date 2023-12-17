require 'set'
@data = File.readlines(
  'input.txt'
).map {|l| l.chomp.chars}

# this rekt me
# shallow cloning...
# @travel_path = @data.clone
@travel_path = @data.map {|x| x.clone}

EMPTY = ?.
MIRRORS = ['/', '\\']
SPLITTERS = ['|', '-']

def move(d, x, y)
  @travel_path[y][x] = ?#
  # ox, oy = x,y
  case d
  when :right
    x += 1
    # y unchanged
  when :left
    x -= 1
    # y unchanged
  when :up
    # x unchanged
    y -= 1
  when :down
    # x unchanged
    y += 1
  else
    raise "Got unknown direction #{d}"
  end
  if y >= @data.size || x >= @data.first.size || x < 0 || y < 0
    return nil
  end
  [@data[y][x], x, y]
end

def mirror_mapping(current_val, heading)
  case current_val
  when '/'
    case heading 
    when :left
      :down
    when :right
      :up
    when :up
      :right
    when :down
      :left
    end
  when '\\'
    case heading 
    when :left
      :up
    when :right
      :down
    when :up
      :left
    when :down
      :right
    end
  end
end

def spliter_mapping(current_val, heading)
  case current_val
  when ?|
    case heading 
    when :left
      [:up, :down]
    when :right
      [:up, :down]
    when :up
      [:up]
    when :down
      [:down]
    end
  when ?-
    case heading 
    when :left
      [:left]
    when :right
      [:right]
    when :up
      [:left, :right]
    when :down
      [:left, :right]
    end
  end
end

x,y = 0,0
current_val = @data[y][x]
if current_val == EMPTY
  heading = :right
elsif MIRRORS.include?(current_val)
  heading = :down
end  
@next_moves = [[heading, x, y]]
@unchanged_count = 0

until @next_moves.empty? || @unchanged_count > 500000
  orig_state = @travel_path.map {|x| x.clone}
  d, x, y = @next_moves.shift
  pnext = move(d, x, y)
  next if pnext.nil?
  current_val, x, y = pnext
  if current_val == EMPTY
    @next_moves << [d, x, y]
  elsif MIRRORS.include?(current_val)
    next_direction = mirror_mapping(current_val, d)
    @next_moves << [next_direction, x, y]
  elsif SPLITTERS.include?(current_val)
    next_directions = spliter_mapping(current_val, d)
    next_directions.each do |d|
      @next_moves << [d, x, y]
    end
  end
  # @travel_path[0..y+10].each{|r| puts r.join[0..x+20]}
  # pp @next_moves
  # pp ?=*100
  end_state = @travel_path.map {|x| x.clone}
  if orig_state == end_state
    @unchanged_count += 1 
  else
    @unchanged_count = 0
  end
end

pp @travel_path.map{|r| r.count(?#)}.sum

