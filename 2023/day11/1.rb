FILE = 'input.txt'
# FILE = 'sample.txt'

# 9804789 too high
# 9799681 2nd attempt

def print_m(data)
  puts "X, #{(0..data.first.size-1).map{|s| s.to_s}.inspect}"
  data.each.with_index {|d,i| puts "#{i}, #{d.inspect}"}
  puts "="*100
end

data = File.readlines(FILE).map{|l| l.chomp.chars}
print_m(data)

col_insert_locs = data.map.with_index {|rows,i| [i, rows.all? {|s| s == ?.}]}.select {|s| s.last }.map(&:first)
count = 0
col_insert_locs.each do |i|
  data.insert(i+1+count, (0..data.first.length-1).map {|s| ?.})
  count += 1
end

row_insert_locs = (0..data.first.size-1).map {|col_i| (0..data.size-1).map {|row_i| data[row_i][col_i]}}.map.with_index {|d,i| [i, d.all?{|s| s == ?.}]}.select {|s| s.last }.map(&:first)
data.each do |row| 
  count = 0
  row_insert_locs.each do |i|
    row.insert(i+1+count, ?.)
    count += 1
  end
end

print_m(data)
gal_id = 0
@gal_locs  = {}
data.each.with_index do |row, row_i|
  row.each.with_index do |col, col_i|
    if data[row_i][col_i] == ?#
      gal_id += 1
      data[row_i][col_i] = gal_id
      @gal_locs[gal_id] = {row_i:, col_i:}
    end
  end
end

print_m(data)
pairs = @gal_locs.keys.combination(2).to_a

def distance_between_pairs(pair)
  p1id, p2id = pair
  p1 = @gal_locs[p1id]
  p2 = @gal_locs[p2id]
  # pp [p1, p2]
  col_diff = p1[:col_i] - p2[:col_i]
  row_diff = p1[:row_i] - p2[:row_i]
  (row_diff.abs + col_diff.abs)
end

mapped = pairs.map {|pair|
  [pair, distance_between_pairs(pair)]
}

pp mapped
pp mapped.map(&:last).sum
