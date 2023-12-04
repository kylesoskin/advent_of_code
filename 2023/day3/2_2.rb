@matrix = File.readlines('input.txt').map {|r| r.chomp.chars}
# @matrix = File.readlines('sample.txt').map {|r| r.chomp.chars}

def get_surrounding(gear)
  x, y = gear
  row_above = @matrix[y-1].dup
  if row_above[x] =~ /\d/
    row_above.insert(x, "*")
  else
    row_above[x] = "*"
  end
  row_above_range = row_above[x-3..x+3]
  
  row_below = @matrix[y+1].dup
  if row_below[x] =~ /\d/
    row_below.insert(x, "*")
  else
    row_below[x] = "*"
  end
  row_below_range = row_below[x-3..x+3]
   
  regex = /\d*\*\d*|\*\d*/
  
  f1 = row_above_range.join.scan(regex)
  f2 = row_below_range.join.scan(regex)
  n1 = f1.first.gsub("*",'').to_i
  n2 = f2.first.gsub("*",'').to_i
 
  pp [gear, row_above_range.join, row_below_range.join, f1, f2, n1, n2, n1*n2]
  n1*n2
end
gears = []
@matrix.each.with_index do |rows, y|
  rows.each.with_index do |columns, x|
    gears << [x, y] if @matrix[y][x] == "*"
  end
end
pp gears.map {|g| 
  get_surrounding(g)
  # gets
}.sum
