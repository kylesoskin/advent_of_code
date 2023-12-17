# frozen_string_literal: true
require 'set'
@data = File.readlines(
  'input.txt'
).map { |l| l.chomp.chars }

# this rekt me
# shallow cloning...
# @travel_path = @data.clone
@travel_path = @data.map(&:clone)

EMPTY = '.'
MIRRORS = ['/', '\\'].freeze
SPLITTERS = ['|', '-'].freeze

def move(d, x, y)
  @travel_path[y][x] = ?#
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
  else
    raise "Got unknown direction #{d}"
  end
  return nil if y >= @data.size || x >= @data.first.size || x.negative? || y.negative?
  [@data[y][x], x, y]
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

x = 0
y = 0
current_val = @data[y][x]
if current_val == EMPTY
  heading = :right
elsif MIRRORS.include?(current_val)
  heading = :down
end
@next_moves = [[heading, x, y]]
@unchanged_count = 0
@been_to = Set.new

until @next_moves.empty? 
  orig_state = @travel_path.map(&:clone)
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
  @next_moves = @next_moves.uniq
  end_state = @travel_path.map(&:clone)
  if orig_state == end_state
    @unchanged_count += 1
  else
    @unchanged_count = 0
  end
end

pp @travel_path.map { |r| r.count('#') }.sum
