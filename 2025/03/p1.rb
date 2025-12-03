# frozen_string_literal: true

# input = 'sample_input.txt'
input = 'input.txt'

BANKS = File.read(input).lines.map(&:chomp)
ITERS = (0..9).to_a.reverse
all = []
BANKS.map do |b|
  digits = b.chars.map(&:to_i)
  ITERS.each do |n|
    found = digits.each_index.select { |index| digits[index] == n }
    next if found.empty?

    dl = digits.length - 1
    nums = found.select { |i| i < dl }.map do |i|
      (i + 1..dl).map do |j|
        [digits[i], digits[j]].join.to_i
      end
    end
    next if nums.empty?

    all << nums.flatten.max
    break
  end
end
pp all.sum
