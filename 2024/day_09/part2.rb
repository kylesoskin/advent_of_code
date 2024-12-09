# frozen_string_literal: true

input = File.read('input.txt').lines[0].chomp.chars

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

def find_seq(arr, seq)
  arr.find_index.with_index { |_v, i| arr[i, seq.size] == seq }
end

def find_with_free_space(disk, looking_for_size)
  i = disk.index { |s| s.each_cons(looking_for_size).any? { |r| r.all? { |e| e == '.' } } }
  j = begin
    find_seq(disk[i], Array.new(looking_for_size, '.'))
  rescue StandardError
    nil
  end
  [i, j]
end

(0..disk.size - 1).to_a.reverse.each do |q|
  next if disk[q].all? { |s| s == '.' }

  i, j = find_with_free_space(disk, disk[q].size)
  next if i.nil?
  next if i > q

  disk[q].each_with_index do |v, vi|
    break if v.nil? || vi.nil?

    disk[i][vi + j] = v
    disk[q][vi] = '.'
  end
end

sum = 0
disk.flatten.each_with_index do |n, i|
  sum += n * i if n.is_a?(Integer)
end
pp sum
