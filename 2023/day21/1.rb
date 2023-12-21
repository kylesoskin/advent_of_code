# frozen_string_literal: true

file, @step_target = ['input.txt', 64]
# file, @step_target = ['sample.txt', 6]
@data = File.readlines(file).map { |l| l.chomp.chars }

def is_invalid_pos?(pos)
  y, x = pos
  x.nil? || y.nil? || y.negative? || x.negative? || y >= @data.size || x >= @data.first.size
end

def mark_and_return_next(curr_pos)
  y, x = curr_pos
  return [] if is_invalid_pos?(curr_pos) || @been_to.include?([@num_step - 1, y, x])
  @been_to << [@num_step, y, x]
  @data[y][x] = 'O'

  up    = [y - 1, x]
  down  = [y + 1, x]
  left  = [y, x - 1]
  right = [y, x + 1]
  [up, down, left, right].reject do |pos|
    y, x = pos
    is_invalid_pos?([y, x]) || @data[y][x] == '#'
  end
end

start_y = @data.index.with_index { |t, _i| t.include?('S') }
start_x = @data[start_y].index('S')
@num_step = 0
@been_to = Set.new
curr_pos = [[start_y, start_x]]

all_states = []
(@step_target+1).times do
  orig_points = curr_pos.clone
  curr_pos = curr_pos.map { |pos| mark_and_return_next(pos) }.flatten(1)
  all_states << @data.map(&:join).join("\n")  
  orig_points.each do |pos|
    y, x = pos
    @data[y][x] = '.'
  end
  @num_step += 1
end

# puts all_states.join("\n\n")
pp all_states.last.lines.map { |r| r.count('O') }.sum 
