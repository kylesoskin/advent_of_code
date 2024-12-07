# frozen_string_literal: true

input = File.read('input.txt').lines.map do |d|
  val, rest = d.split(':')
  split = rest.split(' ')
  [val.to_i, split.map(&:to_i)]
end

valid_counter = []
input.each do |line|
  val, nums = line
  sums = []
  until nums.empty?
    nn = nums.shift
    if sums.empty?
      sums << nn
    else
      adds = sums.map { |s| s + nn }
      muls = sums.map { |s| s * nn }
      ops = sums.map { |s| (s.to_s + nn.to_s).to_i }
      sums = adds.concat(muls).concat(ops)
    end
  end
  valid_counter << val if sums.include?(val)
end
pp valid_counter.sum
