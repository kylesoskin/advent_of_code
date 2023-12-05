BLANK = nil
all = []
all_lines = File.readlines('input.txt').map(&:chomp)

all_lines.map.with_index {|line_content, line_number| 
  nums = line_content.chomp.scan(/\d*/).reject {|x| x.empty?}
  nums.map {|n| 
    index = line_content.index(n)
    line_content.sub!(n, "."*n.length)
    above_index = line_number-1
    below_index = line_number+1
    left_index  = index-1
    right_index = index + n.length

    left  = left_index < 0 ? nil : line_content[left_index]
    right = right_index >= line_content.length ? nil : line_content[right_index]

    left_index = 0 if left_index < 0
    right_index = line_content.length-1 if right_index > line_content.length-1

    above = above_index < 0 ? BLANK : all_lines[above_index][left_index .. left_index + n.length + 1] 
    below = below_index > (all_lines.count-1) ? BLANK : all_lines[below_index][left_index .. left_index + n.length + 1]
    
    all_surrounding = [above, below, left, right].flatten.join
    pp [above, below, left, right]
    no_special_chars = all_surrounding.gsub(/\d/,"").delete(?.).empty?
    all << n.to_i unless no_special_chars
  }
}

# pp all
