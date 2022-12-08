@grid   = File.read('input.txt').lines.map{|l| l.chomp.chars.map(&:to_i)}
@width  = @grid[0].size
@height = @grid.size

def walk_trees(trees,v,c=0)  
  current = trees.shift
  return c if current.nil? 
  c += 1
  return c if current >= v
  walk_trees(trees,v,c)
end

def up_vis?(x,y,v)
  trees = @grid[0..y-1].map {|row| row[x]}.reverse
  walk_trees(trees,v)
end
def down_vis?(x,y,v)
  trees = @grid[y+1..@height].map {|row| row[x]}
  walk_trees(trees,v)
end
def left_vis?(x,y,v)
  trees = @grid[y][0..x-1].reverse
  walk_trees(trees,v)
end
def right_vis?(x,y,v)
  trees = @grid[y][x+1..@width]
  walk_trees(trees,v)
end

all = []
@grid.each.with_index do |row, y|
  row.each.with_index do |v, x|
    if x == 0 || y == 0 || x == @width-1 || y == @height-1
      next
    else  
      up    = up_vis?(x,y,v)
      left  = left_vis?(x,y,v)
      right = right_vis?(x,y,v)    
      down  =  down_vis?(x,y,v)
      m =  (up * left * right * down)
      all << m
    end
  end
end
p all.max