# frozen_string_literal: true

@data = File.readlines(
  'input.txt'
).map { |l| l.chomp.chars }

EMPTY = '.'
MIRRORS = ['/', '\\'].freeze
SPLITTERS = ['|', '-'].freeze

def move(d, x, y)
  @travel_path[y][x] = '#'
  @been_to << [d, x, y]
  case d
  when :right
    x += 1
  when :left
    x -= 1
  when :up
    y -= 1
  when :down
    y += 1
  end
  x.negative? || y.negative? || y > @y_max || x > @x_max ? nil : [@data[y][x], x, y]
end

def mirror_mapping(current_val, heading)
  case current_val
  when '/'
    case heading
    when :left
      :down
    when :right
      :up
    when :up
      :right
    when :down
      :left
    end
  when '\\'
    case heading
    when :left
      :up
    when :right
      :down
    when :up
      :left
    when :down
      :right
    end
  end
end

def spliter_mapping(current_val, heading)
  case current_val
  when '|'
    case heading
    when :left
      %i[up down]
    when :right
      %i[up down]
    when :up
      [:up]
    when :down
      [:down]
    end
  when '-'
    case heading
    when :left
      [:left]
    when :right
      [:right]
    when :up
      %i[left right]
    when :down
      %i[left right]
    end
  end
end

@y_max = @data.size - 1
@x_max = @data.first.size - 1
def get_direction_options(y, x)
  # corners
  if x.zero? && y.zero?
    %i[right down]
  elsif y.zero? && x == @x_max
    %i[left down]
  elsif y == @y_max && x.zero?
    %i[right up]
  elsif y == @y_max && x == @x_max
    %i[left up]
  # everything else
  elsif y.zero?
    [:down]
  elsif x.zero?
    [:right]
  elsif y == @y_max
    [:up]
  elsif x == @x_max
    [:left]
  else
    []
  end
end
xs = (0..@x_max).to_a
ys = (0..@y_max).to_a

all_to_try = []
ys.each do |y|
  xs.each do |x|
    all_to_try << [get_direction_options(y, x), y, x]
  end
end
max = 0
all_to_try.each do |v|
  direction_options, y, x = v
  current_val = @data[y][x]
  direction_options.each do |heading|
    @travel_path = @data.map(&:clone)
    @next_moves = [[heading, x, y]]
    @been_to = Set.new
    until @next_moves.empty?
      d, x, y = @next_moves.shift
      pnext = move(d, x, y)
      next if pnext.nil?

      current_val, x, y = pnext
      if current_val == EMPTY
        n = [d, x, y]
        @next_moves << n unless @been_to.include?(n)
      elsif MIRRORS.include?(current_val)
        next_direction = mirror_mapping(current_val, d)
        n = [next_direction, x, y]
        @next_moves << n unless @been_to.include?(n)
      elsif SPLITTERS.include?(current_val)
        next_directions = spliter_mapping(current_val, d)
        next_directions.each do |d|
          n = [d, x, y]
          @next_moves << n unless @been_to.include?(n)
        end
      end
    end
    v = @travel_path.map { |r| r.count('#') }.sum
    max = v if v > max
  end
end

puts max
