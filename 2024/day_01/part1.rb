# input = 'sample_input.txt'
input = 'input.txt'

left, right, diff = [], [], []

File.read(input).lines do |line|
  l,r = line.chomp.split(" ").map(&:to_i)
  left << l
  right << r
end

left.sort! 
right.sort! 
(0..left.size-1).each do |i|
  l = left[i]
  r = right[i]
  d = (r-l).abs
  diff << d
end
pp diff.sum
