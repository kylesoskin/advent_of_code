GRID_MAX = 6
BYTES_FALLEN = 12
byte_locs = File.read('sample_input.txt').lines.map {|l| l.chomp.split(?,).map(&:to_i)}

# GRID_MAX = 70
# BYTES_FALLEN = 1024
# byte_locs = File.read('input.txt').lines.map {|l| l.chomp.split(?,).map(&:to_i)}


# build grid
@grid = Array.new(GRID_MAX+1) { Array.new(GRID_MAX+1,".")}
@counts = []

def view_grid 
  # puts @grid.map(&:join).join("\n")
  pp @grid
  # gets
end

def bs(a)
  r = a[1]
  c = a[0]
  return nil if r.negative? || c.negative? || r > GRID_MAX || c > GRID_MAX
  @grid[r][c] rescue nil
end

def next_pos_val(curr_pos)
  r, c = curr_pos.dup
  u = [r-1, c]
  d = [r+1, c]
  l = [r, c-1]
  r = [r, c+1]
  [ 
    [u, bs(u)],
    [d, bs(d)],
    [l, bs(l)],
    [r, bs(r)]
  ]
end

def surrounding(pos)
  next_pos_val(pos)
end

def valid_filter(vals)
  vals.reject {|ns| 
    pos, val = ns
    if val.nil?
      true
    elsif val == "#" || val == "."
      true
    elsif pos.any?(&:negative?)
      true
    else 
      false
    end
  }
end

def grid_mark(pos,score)  
  c,r = pos
  surrounding_vals = surrounding(pos)
  valid = valid_filter(surrounding_vals)
  min_vals = valid.map{ |r| r.last+1}
  min_vals << score
  @grid[r][c] = min_vals.min
  min_vals.min
end
def grid_unmark(pos)
  c,r = pos
  @grid[r][c] = "."
end

@score = 0
@shortest_paths = []

def next_pos(curr_pos, been_to_in_path=[])
  @score+=1
  # if curr_pos == [GRID_MAX, GRID_MAX]  
  #   return 
  # end
  been_to_in_path << curr_pos
  next_spots = next_pos_val(curr_pos)
  # pp next_spots
  valid = next_spots.reject {|ns| 
    pos, val = ns
    if been_to_in_path.include?(pos) || val.nil?
      true
    elsif val == "#"
      true
    elsif pos.any?(&:negative?)
      true
    else 
      false
    end
  }
  return been_to_in_path if next_spots.empty? 
  # pp valid; 
  # gets
  s = nil
  res = valid.map {|ns|  
    pos, val = ns
    been_to_in_path << pos
    s = grid_mark(pos, @score)
    # view_grid
        # ; gets
    next_pos(pos, been_to_in_path)
  }
  @score=s+1 unless s.nil?

end

byte_locs.first(BYTES_FALLEN).each do |loc|
  col, row = loc
  @grid[row][col] = "#"
end

@curr_pos = [0,0]
grid_mark(@curr_pos, 0)
puts "Starting grid"
view_grid
final = next_pos(@curr_pos)
puts "Final Grid"
view_grid
pp @grid[GRID_MAX][GRID_MAX]
