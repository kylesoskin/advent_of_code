# input = 'sample_input.txt'
input = 'input.txt'


left, right, diff = [], [], []
File.read(input).lines do |line|
  l,r = line.split(" ").map(&:to_i)
  left << l
  right << r
end

(0..left.size-1).each do |i|
  l = left[i]
  r = right.count(l)
  v = (l * r)
  diff << v
end
pp diff.sum
