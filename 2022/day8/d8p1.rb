@grid   = File.read('input.txt').lines.map{|l| l.chomp.chars.map(&:to_i)}
@width  = @grid[0].size
@height = @grid.size

def up_vis?(x,y,v)
  @grid[0..y-1].map {|row| row[x]}.all? {|t| t < v}
end
def down_vis?(x,y,v)
  @grid[y+1..@height].map {|row| row[x]}.all? {|t| t < v}
end
def left_vis?(x,y,v)
  @grid[y][0..x-1].all? {|t| t < v}
end
def right_vis?(x,y,v)
  @grid[y][x+1..@width].all? {|t| t < v}
end

visible = 0
@grid.each.with_index do |row, y|
  row.each.with_index do |v, x|
    if x == 0 || y == 0 || x == @width-1 || y == @height-1
      visible += 1
      next
    else  
      visible += 1 if up_vis?(x,y,v) || down_vis?(x,y,v) || left_vis?(x,y,v) || right_vis?(x,y,v)
    end
    
  end
end
p visible 