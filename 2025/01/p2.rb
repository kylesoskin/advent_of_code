# frozen_string_literal: true

# input = 'sample_input.txt'
input = 'input.txt'

START_POS = 50
UPPER_LIMIT = 99

num_at_zero = 0
current_pos = START_POS
arr = 0..UPPER_LIMIT

File.readlines(input).each do |line|
  l = line.chars
  direction = l.shift
  steps = l.join.to_i
  puts "Moving #{direction}: #{steps}, Current Position: #{current_pos}"
  steps.times do
    if current_pos.zero?
      puts '  Increment'
      num_at_zero += 1
    end
    if direction == 'L'
      current_pos -= 1
      current_pos = 99 if current_pos == -1
    else # going right
      current_pos += 1
      current_pos = 0 if current_pos == 100
    end
  end
end
puts "Ending pos: #{current_pos}"
puts "Num Zeros: #{num_at_zero}"
