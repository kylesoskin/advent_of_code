# frozen_string_literal: true
require 'pry'
@input = File.read('sample_input.txt').lines.map{|l| l.chomp.chars}
# @input = File.read('input.txt').lines.map{|l| l.chomp.chars}

def get_x_from(row, col)
  return nil if [[row-1,col+1], [row+1,col-1], [row-1,col-1], [row+1,col+1]].any? {|r,c| out_of_bounds(r,c)}
  char = @input[row][col]
  left_up = @input[row-1][col+1]
  left_down = @input[row+1][col-1]
  right_up = @input[row-1][col-1]
  right_down = @input[row+1][col+1]
  diag_one = left_up + char + right_down
  diag_two = right_up + char + left_down
  return [diag_one, diag_two]
end

def out_of_bounds(row, col)
  row < 0 || col < 0 || row > @row_index_max || col > @col_index_max
end

def is_valid_x(arr)
  return nil if arr.nil?
  f = [arr[0], arr[0].reverse]
  s = [arr[1], arr[1].reverse]
  f.any?{|s| s == "MAS"} && s.any?{|s| s == "MAS"}
end

@row_index_max = @input.count-1
@col_index_max = @input.first.count-1
results = []
(0..@row_index_max).each do |row|
  (0..@col_index_max).each do |col|
    x = get_x_from(row, col)
    results << {row:, col:, start_letter: @input[row][col], arr_x_result: x, is_x: is_valid_x(x)}
  end
end
pp results.count{|d| d[:is_x]}