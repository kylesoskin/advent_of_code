# frozen_string_literal: true

# input = 'sample_input.txt'
input = 'input.txt'

RED = '#'
GREEN = 'X'
EMPTY = '.'

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

def find_all_rect(points)
  all_possible = []
  points.each_with_index do |p1, i|
    ((i + 1)...points.length).each do |j|
      p2 = points[j]

      dim1 = (p2.y - p1.y).abs + 1
      dim2 = (p2.x - p1.x).abs + 1
      all_possible << [[p1, p2], dim1 * dim2]
    end
  end
  all_possible
end

def go_up_to_edge_or_point(point, data, find = RED, set = GREEN)
  curr_y = point.y - 1
  found_num_sign = nil

  while curr_y >= 0
    row = data[curr_y]  
    break if row.nil?   

    if row[point.x] == find
      found_num_sign = curr_y
      break
    end
    curr_y -= 1
  end

  return if found_num_sign.nil?

  (point.y - 1).downto(found_num_sign + 1) do |y|
    data[y] ||= {}      
    data[y][point.x] = set
  end
end


def go_left_to_edge_or_point(point, data, find = RED, set = GREEN)
  curr_x = point.x - 1
  found_num_sign = nil

  while curr_x >= 0
    row = data[point.y]          # do NOT auto-create a row
    break if row.nil?            # treat missing row as default '.'

    if row[curr_x] == find
      found_num_sign = curr_x
      break
    end

    curr_x -= 1
  end

  return if found_num_sign.nil?

  (point.x - 1).downto(found_num_sign + 1) do |x|
    data[point.y] ||= {}         # create row only when writing
    data[point.y][x] = set
  end
end


def all_points_in_rect_are_red_or_green?(points, data)
  p1, p2 = points[0]
  x_start = [p1.x, p2.x].min # 2
  x_end = [p1.x, p2.x].max # 9
  y_start = [p1.y, p2.y].min # 3
  y_end = [p1.y, p2.y].max # 5
  (y_start..y_end - 1).each do |y|
    (x_start..x_end).each do |x|
      cell = data[y][x]
      return false unless RED == cell || GREEN == cell
    end
  end
  true
end

def fill_greens(green_points, data)
  visited = Set.new
  queue = green_points.dup
  count = 0
  puts "On point #{count} of #{green_points.length}"
  
  until queue.empty?
    point = queue.shift
    key = [point.x, point.y]
    next if visited.include?(key)
    visited.add(key)
    
    # Process up direction
    curr_y = point.y - 1
    found_num_sign = nil
    while curr_y >= 0
      row = data[curr_y]
      break if row.nil?
      if row[point.x] == RED || row[point.x] == GREEN
        found_num_sign = curr_y
        break
      end
      curr_y -= 1
    end
    
    if found_num_sign
      (point.y - 1).downto(found_num_sign + 1) do |y|
        data[y] ||= {}
        if data[y][point.x] != GREEN
          data[y][point.x] = GREEN
          queue << Point.new(point.x, y)
        end
      end
    end
    
    # Process left direction
    curr_x = point.x - 1
    found_num_sign = nil
    while curr_x >= 0
      row = data[point.y]
      break if row.nil?
      if row[curr_x] == RED || row[curr_x] == GREEN
        found_num_sign = curr_x
        break
      end
      curr_x -= 1
    end
    
    if found_num_sign
      (point.x - 1).downto(found_num_sign + 1) do |x|
        data[point.y] ||= {}
        if data[point.y][x] != GREEN
          data[point.y][x] = GREEN
          queue << Point.new(x, point.y)
        end
      end
    end
  end
end

points = File.readlines(input, chomp: true).map do |l|
  x, y = l.split(',')
  Point.new(x, y)
end

# Draw inital grid
m_x = points.map(&:x).max
m_y = points.map(&:y).max
# data = Array.new(m_y + 2) { Array.new(m_x + 1, EMPTY) } # huge needs 100s of GB of RAM :( 
data = grid = Hash.new { |h, y| h[y] = Hash.new(EMPTY) }

pp "Got here ok, 1"

points.each do |point|
  data[point.y][point.x] = RED
end

# For all point, traverse up and left to next
points.each { |point|  go_up_to_edge_or_point(point, data) }
points.each { |point|  go_left_to_edge_or_point(point, data) }

pp "Got here ok, 2"

# Fill in greens
## Get greens
green_points = []
data.each do |y, row|
  row.each do |x, cell|
    green_points << Point.new(x, y) if cell == GREEN
  end
end

pp "Got here ok, 3"
fill_greens(green_points, data)

pp "Got here ok, 4"

rects = find_all_rect(points)
pp "Got here ok, 5"

pp rects.select { |points| all_points_in_rect_are_red_or_green?(points, data) }.max_by(&:last)

# display(data)
