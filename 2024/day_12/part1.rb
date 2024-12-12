# frozen_string_literal: true

require 'pry'
# @input = File.read('sample_input.txt').lines.map{|l| l.chomp.chars}
@input = File.read('input.txt').lines.map { |l| l.chomp.chars }

@row_index_max = @input.size - 1
@col_index_max = @input.first.size - 1

def out_of_bounds(row, col)
  row.negative? || col.negative? || row > @row_index_max || col > @col_index_max
end

def oob_or_nil(row, col)
  out_of_bounds(row, col) ? nil : @input[row][col]
end

def right(row, col, letter)
  op = [row, col].dup
  spaces_traversed = []
  curr_letter = letter
  until out_of_bounds(row, col) || curr_letter != letter
    spaces_traversed << [row, col]
    col += 1
    break if out_of_bounds(row, col)

    curr_letter = @input[row][col]
  end
  spaces_traversed.delete_if { |d| op == [d[0], d[1]] }
end

def left(row, col, letter)
  op = [row, col].dup
  spaces_traversed = []
  curr_letter = letter
  until out_of_bounds(row, col) || curr_letter != letter
    spaces_traversed << [row, col]
    col -= 1
    break if out_of_bounds(row, col)

    curr_letter = @input[row][col]
  end
  spaces_traversed.delete_if { |d| op == [d[0], d[1]] }
end

def up(row, col, letter)
  op = [row, col].dup
  spaces_traversed = []
  curr_letter = letter
  until out_of_bounds(row, col) || curr_letter != letter
    spaces_traversed << [row, col]
    row -= 1
    break if out_of_bounds(row, col)

    curr_letter = @input[row][col]
  end
  spaces_traversed.delete_if { |d| op == [d[0], d[1]] }
end

def down(row, col, letter)
  op = [row, col]
  spaces_traversed = []
  curr_letter = letter
  until out_of_bounds(row, col) || curr_letter != letter
    spaces_traversed << [row, col]
    row += 1
    break if out_of_bounds(row, col)

    curr_letter = @input[row][col]
  end
  spaces_traversed.delete_if { |d| op == [d[0], d[1]] }
end

def already_grouped(row, col, letter)
  @results.any? do |r|
    r[:letter] == letter && (r[:right] + r[:left] + r[:up] + r[:down]).include?([row, col])
  end
end

def get_all_points(group)
  all = []
  group.each do |g|
    all << ([[[g[:row], g[:col]]] + g[:right] + g[:left] + g[:up] + g[:down]])
  end
  all.flatten(2).uniq
end

def area(group)
  a = get_all_points(group)
  a.count
end

def perimiter(groups)
  face_count = 0
  points = get_all_points(groups)
  points.each do |point|
    row, col = point
    up = oob_or_nil(row - 1, col)
    down = oob_or_nil(row + 1, col)
    left = oob_or_nil(row, col - 1)
    right = oob_or_nil(row, col + 1)
    nbs = [up, down, left, right]
    to_add = nbs.count { |d| d == 1 || d != @input[row][col] }
    face_count += to_add
  end
  face_count
end

@row_index_max = @input.count - 1
@col_index_max = @input.first.count - 1
@results = []
(0..@row_index_max).each do |row|
  (0..@col_index_max).each do |col|
    letter = @input[row][col]
    next if already_grouped(row, col, letter)

    right = right(row, col, letter)
    left  = left(row, col, letter)
    up = up(row, col, letter)
    down = down(row, col, letter)
    r = { row:, col:, letter:, right:, left:, up:, down: }
    @results << r
  end
end

@groups = []

Marshal.load(Marshal.dump(@results)).each do |q|
  looking_for = (q[:right] + q[:left] + q[:up] + q[:down])
  lfl = q[:letter]
  over_all_results = []
  connected_result = @results.select do |r|
    (r != q) && (r[:letter] == lfl) && ((r[:right] + r[:left] + r[:up] + r[:down]) & looking_for).any?
  end
  over_all_results << connected_result
  over_all_results.flatten!
  until connected_result.empty?
    over_all_results.each do |ovr|
      looking_for = (ovr[:right] + ovr[:left] + ovr[:up] + ovr[:down])
      connected_result = @results.select do |r|
        (r != ovr) && (ovr[:letter] == r[:letter]) && ((r[:right] + r[:left] + r[:up] + r[:down]) & looking_for).any?
      end
      next if connected_result.empty?

      over_all_results << connected_result
      over_all_results.flatten!
      connected_result.each do |cr|
        @results.delete(cr)
      end
    end
  end
  @groups << [q, over_all_results].flatten unless @groups.any? { |g| get_all_points(g).include?([q[:row], q[:col]]) }
end
# pp @groups
# pp ["remaining", @results]
# pp @groups.count
# pp @groups.map {|g| [g.first[:row], g.first[:col], g.first[:letter], a=area(g), per=perimiter(g), a * per] }
pp @groups.map { |g|
  area(g) * perimiter(g)
}.sum
