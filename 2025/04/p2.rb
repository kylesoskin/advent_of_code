# frozen_string_literal: true

# input = 'sample_input.txt'
input = 'input.txt'

@data = File.readlines(input).map { |l| l.chomp.chars }

def get(x, y)
  return nil if x > @data.size - 1 || x.negative?
  return nil if y > @data[0].size - 1 || y.negative?

  @data[x][y]
end

def get_results
  results = []
  @data.each.with_index do |row, x|
    row.each.with_index do |_col, y|
      up    = get(x - 1, y)
      down  = get(x + 1, y)
      left  = get(x, y - 1)
      right = get(x, y + 1)
      nw = get(x - 1, y - 1)
      ne = get(x - 1, y + 1)
      sw = get(x + 1, y - 1)
      se = get(x + 1, y + 1)
      results << [x, y, get(x, y), [up, down, left, right, nw, ne, sw, se].count('@')]
    end
  end
  results.select { |r| r[2] == '@' && r.last < 4 }
end

def remove_rolls(results)
  results.each do |r|
    @data[r[0]][r[1]] = '.'
  end
  results.count
end

removed_count = 0
r = get_results
until r.count.zero?
  removed_count += remove_rolls(r)
  r = get_results
end
puts removed_count
