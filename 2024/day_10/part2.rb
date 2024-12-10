# frozen_string_literal: true

input = File.read('input.txt')

@grid = input.lines.map { |l| l.chomp.chars.map(&:to_i) }
ROW_MAX = @grid.size - 1
COL_MAX = @grid.first.size - 1

def gg(row, col)
  return nil if row_oob?(row).nil? || col_oob?(col).nil?

  @grid[row][col]
end

def row_oob?(row)
  row.negative? || row > ROW_MAX ? nil : row
end

def col_oob?(col)
  col.negative? || col > COL_MAX ? nil : col
end

def surrounding_cords_and_val(row, col)
  up    = [row_oob?(row - 1), col_oob?(col), gg(row - 1, col)]
  down  = [row_oob?(row + 1), col_oob?(col), gg(row + 1, col)]
  left  = [row_oob?(row), col_oob?(col - 1), gg(row, col - 1)]
  right = [row_oob?(row), col_oob?(col + 1), gg(row, col + 1)]
  { up:, down:, left:, right: }
end

def trailheads
  ret = []
  @grid.each_with_index do |row, ri|
    row.each_with_index do |col, ci|
      ret << [ri, ci] if col.zero?
    end
  end
  ret
end

def get_nexts(curr_row, curr_col, curr_v, result = [])
  if curr_v == 9
    result = [curr_row, curr_col]
  else
    next_pos = surrounding_cords_and_val(curr_row, curr_col)
    go_to = next_pos.values.select { |x, y, v| v == curr_v + 1 && (!x.nil? && !y.nil?) }
    result = go_to.map { |x, y, v| get_nexts(x, y, v, result) }
  end
  result
end
counts = []
trailheads.each do |s_row, s_col|
  counts << get_nexts(s_row, s_col, gg(s_row, s_col))
end
pp counts.map { |x| x.flatten(8).count }.sum
