# frozen_string_literal: true

input = 'sample_input.txt'
# input = 'input.txt'

RED = '#'
GREEN = 'X'

class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x.to_i
    @y = y.to_i
  end
end

def display(d)
  puts d.map(&:join).join("\n")
end

points = File.readlines(input, chomp: true).map do |l|
  x, y = l.split(',')
  Point.new(x, y)
end

def find_all_rect(points)
  all_possible = []
  points.combination(2).each do |points|
    p1, p2 = points

    dim1 = [p2.y - p1.y + 1, p1.y - p2.y + 1].max
    dim2 = [p2.x - p1.x + 1, p1.x - p2.x + 1].max

    all_possible << [points, dim1, dim2, dim1 * dim2]
  end
  all_possible
end

def go_up_to_edge_or_point(point, data, find = RED, set = GREEN)
  curr_y = point.y - 1
  found_num_sign = nil
  while curr_y >= 0
    if data[curr_y][point.x] == find
      found_num_sign = curr_y
      break
    end
    curr_y -= 1
  end
  return if found_num_sign.nil?

  (point.y - 1).downto(found_num_sign + 1) do |y|
    data[y][point.x] = set
  end
end

def go_left_to_edge_or_point(point, data, find = RED, set = GREEN)
  curr_x = point.x - 1
  found_num_sign = nil
  while curr_x >= 0
    if data[point.y][curr_x] == find
      found_num_sign = curr_x
      break
    end
    curr_x -= 1
  end
  return if found_num_sign.nil?

  (point.x - 1).downto(found_num_sign + 1) do |x|
    data[point.y][x] = set
  end
end

def all_points_in_rect_are_red_or_green?(points, data)
  p1, p2 = points[0]
  x_start = [p1.x, p2.x].min # 2
  x_end = [p1.x, p2.x].max # 9
  y_start = [p1.y, p2.y].min # 3
  y_end = [p1.y, p2.y].max # 5
  # log = true if [x_start, x_end, y_start, y_end] == [2, 9, 3, 5]
  # pp ["logging", [x_start, x_end, y_start, y_end]] if log
  (y_start..y_end - 1).each do |y|
    (x_start..x_end).each do |x|
      # pp ["logging cell", x, y, data[y][x]] if log
      cell = data[y][x]
      return false unless [RED, GREEN].include?(cell)
    end
  end
  true
end

def fill_greens(green_points, data)
  green_points.each do |point|
    go_up_to_edge_or_point(point, data, GREEN, GREEN)
    go_left_to_edge_or_point(point, data, GREEN, GREEN)
  end
end

# Draw inital grid
m_x = points.map(&:x).max
m_y = points.map(&:y).max
data = []
(0..m_y + 1).each do |_y|
  a = []
  (0..m_x + 1).each do |_x|
    a << '.'
  end
  data << a
end
points.each do |point|
  data[point.y][point.x] = RED
end

# For all point, traverse up and left to next
points.each { |point|     go_up_to_edge_or_point(point, data) }
points.each { |point|    go_left_to_edge_or_point(point, data) }


# Fill in greens
## Get greens
green_points = []
data.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    green_points << Point.new(x, y) if cell == GREEN
  end
end
fill_greens(green_points, data)

pp find_all_rect(points).select { |points| all_points_in_rect_are_red_or_green?(points, data) }.max_by(&:last)

# display(data)
