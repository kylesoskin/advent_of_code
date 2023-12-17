require 'set'
@data = File.readlines(
  'sample.txt'
).map {|l| l.chomp.chars}

@travel_path = @data.clone

EMPTY = ?.
MIRRORS = ['/', '\\']
SPLITTERS = ['|', '-']
@been_to = Set.new
@move_count = 0 

def move(d, x, y)
  # @travel_path[y][x] = ?#
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
    pp ["got x,y of #{[x,y].to_s}, returning nil"]
    return nil
  end
  @been_to << [x,y]
  cs = @data[y][x]
  [cs, x, y]
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
heading = :right
@next_moves = [[heading, x, y]]

until @next_moves.empty?
  d, x, y = @next_moves.shift
  pnext = move(d, x, y)
  next if pnext.nil?
  current_val, x, y = pnext
  @move_count += 1
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
  pp [@travel_path, @next_moves, current_val, x, y]
  gets
end

