BLANK = nil
all = []
all_lines = File.readlines('input.txt').map(&:chomp)
# all_lines = File.readlines('sample.txt').map(&:chomp)

cord_ids = {}
coord_list = []
all_lines.each.with_index do |rows, y|
  rows.chars.each.with_index do |columns, x|
    if all_lines[y][x] == "*"
      g = [x, y]
      cord_ids[g] = []
      coord_list << g
    end
  end
end

res = {}
all_lines.map.with_index {|line_content, line_number| 
  nums = line_content.chomp.scan(/\d*/).reject {|x| x.empty?}
  nums.map {|n| 
    index = line_content.index(n)
    rows_to_check = (line_number-1..line_number+1).select {|x| x>0}
    columns_to_check = (index-1..index+n.size).select {|x| x>0}
    coords_to_check = []
    rows_to_check.each {|y| columns_to_check.each {|x| coords_to_check << [x, y]}}
    intersection = (cord_ids.keys & coords_to_check)
    intersection.each do |p|
      res[p] ||= []
      res[p] << n.to_i
    end
    line_content.sub!(n, "."*n.length)  
  }
}

pp res.values.select {|v| v.size == 2}.map {|v| v[0]*v[1]}.sum