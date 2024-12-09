# frozen_string_literal: true

@input = File.read('input.txt').lines.map { |l| l.chomp.chars }
@input_display = Marshal.load(Marshal.dump(@input))

ROW_MAX = @input.size - 1
COL_MAX = @input.first.size - 1

def find_locations(val)
  results = []
  @input.each_with_index do |row, ri|
    row.each_with_index do |col, ci|
      results << [ri, ci] if col == val
    end
  end
  results
end

def find_all_uniq_attn
  @input.map(&:uniq).flatten.uniq - ['.']
end

def manhattan_distance(p1, p2)
  x1, y1 = p1
  x2, y2 = p2
  (x2 - x1).abs + (y2 - y1).abs
end

def get_antinodes(p1, p2)
  row1, col1 = p1
  row2, col2 = p2
  vert_diff = row2 - row1
  horz_diff = col2 - col1
  anti_node1 = [row1 - vert_diff, col1 - horz_diff]
  anti_node2 = [row2 + vert_diff, col2 + horz_diff]
  [anti_node1, anti_node2]
end

def out_of_bounds(row, col)
  row > ROW_MAX || row.negative? || col.negative? || col > COL_MAX
end

points = find_all_uniq_attn.map { |l| [l, find_locations(l)] }
points.each do |val, cords|
  puts "#{val}, #{cords}"
  cords.each_with_index do |curr_cord, _i|
    all_other_cords = cords - [curr_cord]
    all_other_cords.each do |other_cord|
      anti_nodes = get_antinodes(curr_cord, other_cord)
      pp anti_nodes
      anti_nodes.each do |row, col|
        next if out_of_bounds(row, col)

        @input_display[row][col] = '#'
      end
    end
  end
end
puts @input_display.map(&:join).join("\n")
an_count = @input_display.flatten.count('#')
puts "Antinode count=#{an_count}"
