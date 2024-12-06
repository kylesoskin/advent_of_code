# frozen_string_literal: true

# golden_input = File.read('sample_input.txt').lines.map {|l| l.chomp.chars}
golden_input = File.read('input.txt').lines.map { |l| l.chomp.chars }

class WalkInstance
  attr_accessor :input, :heading, :cur_row, :cur_col

  def shift_90
    case @heading
    when :up
      @heading = :right
    when :down
      @heading = :left
    when :left
      @heading = :up
    when :right
      @heading = :down
    end
  end

  def move
    @cur_row, @cur_col = next_pos
    @input[@cur_row][@cur_col] = 'X'
  end

  def next_pos
    case @heading
    when :up
      [@cur_row - 1, @cur_col]
    when :down
      [@cur_row + 1, @cur_col]
    when :left
      [@cur_row, @cur_col - 1]
    when :right
      [@cur_row, @cur_col + 1]
    end
  end

  def next_val
    next_row, next_col = next_pos
    if next_row > @input_size || next_col > @input_f_s || next_col.negative? || next_row.negative?
      return nil
    end

    @input[next_row][next_col]
  rescue StandardError
    nil
  end

  def walk!    
    steps = 0
    until @done || steps > 10_000
      steps += 1
      n = next_val
      if n.nil?
        @done = true
      elsif ['.', 'X', '^'].include?(n)
        move
      else
        shift_90
      end
    end
    steps
  end

  def initialize(x,start)
    @heading = :up
    @done = false
    @input = x
    @cur_row, @cur_col = start
    @input_size = @input.size - 1
    @input_f_s = @input.first.size - 1
  end
end
results = []

def find_start(input)
  input.each_with_index do |row, r|
    row.each_with_index do |val, c|
      return [r, c] if val == '^'
    end
  end
end
start = find_start(golden_input)
golden_input.each_with_index do |r, ri|
  r.each_with_index do |_c, ci|
    new_input = Marshal.load(Marshal.dump(golden_input))
    new_input[ri][ci] = '0'
    x = WalkInstance.new(new_input, start)
    steps = x.walk!
    res = { ri:, ci:, steps: }
    results << res
  end
end
# pp results.map { |d| d[:steps]}.sort
pp(results.count { |d| d[:steps] > 10_000 })
