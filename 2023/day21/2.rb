# frozen_string_literal: true
# file = 'input.txt'
# @step_target = 64
file, @step_target = ['sample.txt', 1000]
@data = File.readlines(file).map { |l| l.chomp.chars }
@traversal = {}
@y_size = @data.size
@x_size = @data.first.size

def get_char_from_hypothetical_pos(pos)
  y, x = pos
  ny = (y % @y_size) 
  nx = (x % @y_size) 
  @data[ny][nx]
end

def mark_and_return_next(curr_pos)
  y, x = curr_pos
  @traversal[y] ||= {}
  @traversal[y][x] = 'O'
  up    = [y - 1, x]
  down  = [y + 1, x]
  left  = [y, x - 1]
  right = [y, x + 1]
  [up, down, left, right].reject {|pos| get_char_from_hypothetical_pos(pos) == '#'}
end

start_y = @data.index.with_index { |t, _i| t.include?('S') }
start_x = @data[start_y].index('S')
@num_step = 0
curr_pos = [[start_y, start_x]]
counts = nil
(@step_target + 1).times do
  curr_pos = curr_pos.map { |pos| mark_and_return_next(pos) }.flatten(1).uniq
  counts = @traversal.values.map{|h| h.keys.count}.sum + 1
  @traversal = {}
  @num_step += 1
end

pp counts - 1
