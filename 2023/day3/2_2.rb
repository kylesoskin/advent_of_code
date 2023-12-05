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
  
  left = @matrix[y][x-3..x]
  right = @matrix[y][x..x+3]

  regex = /\d{1,3}\*\d{1,3}|\*\d{1,3}|\d{1,3}\*/
  
  f1 = row_above_range.join.scan(regex)
  f2 = row_below_range.join.scan(regex)
  if f1.empty? || f2.empty? 
    v = [f1, f2].reject {|f| f.empty?}[0]
    if v.nil?
      n1 = 0
      n2 = 0
    else  
      n1, n2 = v[0].split(?*).map(&:to_i)
    end
  else
    n1 = f1.first.gsub("*",'').to_i
    n2 = f2.first.gsub("*",'').to_i   
  end
  if n1.to_i == 0 || n2.to_i == 0
    n1 = n1.to_i
    n2 = n2.to_i
    has_val = [n1,n2].max
    if has_val != 0
      n1 = has_val
      n2 = [left.join.scan(/\d*/).map(&:to_i).max, right.join.scan(/\d*/).map(&:to_i).max].max
    end
  end

  pp [gear, row_above_range.join, row_below_range.join, f1, f2, n1, n2, n1.to_i*n2.to_i] if n1.to_i*n2.to_i == 0
  n1.to_i*n2.to_i
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
