# input = 'sample_input.txt'
input = 'input.txt'

levels = File.read(input).lines

def is_increasing_or_decreasing(n, d)
  n.uniq.size == n.size && (d.all? {|f| f.positive?} || d.all? {|f| f.negative?})
end

def delta_range(d, min=1, max=3)
  d.all? {|f| f.abs.between?(min, max)}
end

def is_safe?(n, d)
  is_increasing_or_decreasing(n, d) && delta_range(d)
end
results = []
levels.each do |level|
  nums = level.chomp.split(" ").map(&:to_i)
  delta_accumulator = []
  nums.each_with_index do |num, index|
    next if index == nums.size-1
    delta_accumulator << nums[index+1] - num
  end
  results << is_safe?(nums, delta_accumulator)
end
pp results.count(true)