# frozen_string_literal: true

input = 'sample_input.txt'
# input = 'input.txt'

START_POS = 50
UPPER_LIMIT = 99

num_at_zero = 0
current_pos = START_POS
arr = 0..UPPER_LIMIT
arr = arr.to_a.rotate(START_POS)

File.readlines(input).each do |line|
  l = line.chars
  direction = l.shift
  steps = l.join.to_i
  puts "Moving #{direction}: #{steps}"
  arr.rotate!(direction == 'L' ? (0 - steps) : steps)
  current_pos = arr.first
  puts "Landed at: #{current_pos}"
  if current_pos.zero?
    num_at_zero += 1
    puts "Landed on zero! Total so far: #{num_at_zero}"
  end
end
puts "Final position: #{current_pos}"
puts "Number of times landed on zero: #{num_at_zero}"
