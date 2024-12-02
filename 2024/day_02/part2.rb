# frozen_string_literal: true

# input = 'sample_input.txt'
input = 'input.txt'

levels = File.read(input).lines

def increasing_or_decreasing?(n, d)
  n.uniq.size == n.size && (d.all?(&:positive?) || d.all?(&:negative?))
end

def delta_range(d, min = 1, max = 3)
  d.all? { |f| f.abs.between?(min, max) }
end

def safe?(n, d)
  increasing_or_decreasing?(n, d) && delta_range(d)
end

def less_one_combos(nums)
  (0..nums.size - 1).map do |n|
    new_array = nums.dup
    new_array.delete_at(n)
    new_array
  end
end

def nums_are_safe?(nums, delta_accumulator = [])
  nums.each_with_index do |num, index|
    next if index == nums.size - 1

    delta_accumulator << nums[index + 1] - num
  end
  safe?(nums, delta_accumulator)
end

final_results = 0
levels.each do |level|
  nums = level.chomp.split(' ').map(&:to_i)
  final_results += 1 if nums_are_safe?(nums) || less_one_combos(nums).any? { |nums| nums_are_safe?(nums) == true }
end
pp final_results
