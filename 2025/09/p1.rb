# frozen_string_literal: true

# input = 'sample_input.txt'
input = 'input.txt'

class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x.to_i
    @y = y.to_i
  end
end

points = File.readlines(input, chomp: true).map do |l|
  x, y = l.split(',')
  Point.new(x, y)
end
all_possible = []
points.combination(2).each do |points|
  p1, p2 = points

  dim1 = [p2.y - p1.y + 1, p1.y - p2.y + 1].max
  dim2 = [p2.x - p1.x + 1, p1.x - p2.x + 1].max

  all_possible << [points, dim1, dim2, dim1 * dim2]
end
pp(all_possible.max_by(&:last))
