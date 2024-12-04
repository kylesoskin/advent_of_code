# frozen_string_literal: true

require 'pry'
# @input = File.read('sample_input.txt').lines.map{|l| l.chomp.chars}
@input = File.read('input.txt').lines.map { |l| l.chomp.chars }

def search_down(row, col)
  return nil if [[row, col], [row + 1, col], [row + 2, col], [row + 3, col]].any? { |r, c| out_of_bounds(r, c) }

  @input[row][col] +
    @input[row + 1][col] +
    @input[row + 2][col] +
    @input[row + 3][col]
rescue StandardError
  nil
end

def search_up(row, col)
  return nil if [[row, col], [row - 1, col], [row - 2, col], [row - 3, col]].any? { |r, c| out_of_bounds(r, c) }

  @input[row][col] +
    @input[row - 1][col] +
    @input[row - 2][col] +
    @input[row - 3][col]
rescue StandardError
  nil
end

def search_left(row, col)
  return nil if [[row, col], [row, col - 1], [row, col - 2], [row, col - 3]].any? { |r, c| out_of_bounds(r, c) }

  @input[row][col] +
    @input[row][col - 1] +
    @input[row][col - 2] +
    @input[row][col - 3]
rescue StandardError
  nil
end

def search_right(row, col)
  return nil if [[row, col], [row, col + 1], [row, col + 2], [row, col + 3]].any? { |r, c| out_of_bounds(r, c) }

  @input[row][col] +
    @input[row][col + 1] +
    @input[row][col + 2] +
    @input[row][col + 3]
rescue StandardError
  nil
end

def diag_left_up_str(row, col)
  return nil if [[row, col], [row - 1, col - 1], [row - 2, col - 2], [row - 3, col - 3]].any? do |r, c|
                  out_of_bounds(r, c)
                end

  @input[row][col] +
    @input[row - 1][col - 1] +
    @input[row - 2][col - 2] +
    @input[row - 3][col - 3]
rescue StandardError
  nil
end

def diag_left_down_str(row, col)
  return nil if [[row, col], [row + 1, col - 1], [row + 2, col - 2], [row + 3, col - 3]].any? do |r, c|
                  out_of_bounds(r, c)
                end

  @input[row][col] +
    @input[row + 1][col - 1] +
    @input[row + 2][col - 2] +
    @input[row + 3][col - 3]
rescue StandardError
  nil
end

def diag_right_up_str(row, col)
  return nil if [[row, col], [row - 1, col + 1], [row - 2, col + 2], [row - 3, col + 3]].any? do |r, c|
                  out_of_bounds(r, c)
                end

  @input[row][col] +
    @input[row - 1][col + 1] +
    @input[row - 2][col + 2] +
    @input[row - 3][col + 3]
rescue StandardError
  nil
end

def diag_right_down_str(row, col)
  return nil if [[row, col], [row + 1, col + 1], [row + 2, col + 2], [row + 3, col + 3]].any? do |r, c|
                  out_of_bounds(r, c)
                end

  @input[row][col] +
    @input[row + 1][col + 1] +
    @input[row + 2][col + 2] +
    @input[row + 3][col + 3]
rescue StandardError
  nil
end

def search(row, col)
  [diag_left_up_str(row, col),
   diag_left_down_str(row, col),
   diag_right_up_str(row, col),
   diag_right_down_str(row, col),
   search_up(row, col),
   search_down(row, col),
   search_left(row, col),
   search_right(row, col)]
end

def out_of_bounds(row, col)
  row.negative? || col.negative? || row > @row_index_max || col > @col_index_max
end

@row_index_max = @input.count - 1
@col_index_max = @input.first.count - 1
results = []
(0..@row_index_max).each do |row|
  (0..@col_index_max).each do |col|
    results << { row:, col:, start_letter: @input[row][col], count: search(row, col).count('XMAS'),
                 arr_result: search(row, col) }
  end
end

# pp results.select {|r| r[:count] > 0}
puts(results.sum { |r| r[:count] })
