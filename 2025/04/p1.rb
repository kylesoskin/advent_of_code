# frozen_string_literal: true

# input = 'sample_input.txt'
input = 'input.txt'

DATA = File.readlines(input).map { |l| l.chomp.chars }

def get(x, y)
  return nil if x > DATA.size - 1 || x.negative?
  return nil if y > DATA[0].size - 1 || y.negative?

  DATA[x][y]
end

results = []
DATA.each.with_index do |row, x|
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
puts(results.count { |r| r[2] == '@' && r.last < 4 })
