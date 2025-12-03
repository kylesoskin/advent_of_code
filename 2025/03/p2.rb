# frozen_string_literal: true

# input = 'sample_input.txt'
input = 'input.txt'

def has_x_to_right(digits, pos, x)
  pos - 1 + x < digits.length
end

BANKS = File.read(input).lines.map(&:chomp)
all = []
BANKS.map do |b|
  digits = b.chars.map(&:to_i)
  d1, curr_index, = digits.map.with_index do |v, i|
    [v, i, has_x_to_right(digits, i, 12)]
  end.select(&:last).max_by(&:first)

  final = [d1]
  (0..11).each do |c|
    d, curr_index, = digits.map.with_index.select do |_v, i|
      i > curr_index
    end.map { |v, i| [v, i, has_x_to_right(digits, i, 11 - c)] }.select { |s| s.last == true }.max_by(&:first)
    final << d
  end
  all << final.join[0..11].to_i
end

pp all.sum
