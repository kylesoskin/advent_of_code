# frozen_string_literal: true

# input = File.read('input.txt').lines[0].chomp.chars
input = File.read('sample_input.txt').lines[0].chomp.chars

i = 0
disk = []
until input.empty?
  blocks = input.shift
  free_space = input.shift
  disk << Array.new(blocks.to_i, i)
  disk << Array.new(free_space.to_i, '.')
  i += 1
end
disk.reject!(&:empty?)

def move_blocks(disk)
  first_free_space = disk.find_index { |x| x.include?('.') }
  last_block_index = disk.size - 1 - disk.reverse.find_index { |x| x.any? { |s| s.is_a?(Integer) } }
  repl_loc = disk[first_free_space].index('.')
  swap_loc = disk[last_block_index].rindex { |z| z.is_a?(Integer) }
  disk[first_free_space][repl_loc], disk[last_block_index][swap_loc] = disk[last_block_index][swap_loc],
disk[first_free_space][repl_loc]
  disk
end

move_blocks(disk) until disk.flatten.join =~ /^\d*\.*$/
nd = disk.flatten.select { |s| s.is_a?(Integer) }
sum = 0
nd.each_with_index do |n, i|
  sum += n * i
end
pp sum
