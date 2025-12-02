# frozen_string_literal: true

input = 'sample_input.txt'
# input = 'input.txt'

def is_mirror?(num)
  chars = num.to_s.chars
  return false if chars.count.odd?

  l = chars[0..((chars.length - 1) / 2)]
  r = chars[(chars.length / 2)..]
  l == r
end
pp File.read(input).lines.first.split(',').map { |r|
  s, e = r.split('-')
  (s.to_i..e.to_i).select { |x| is_mirror?(x) }
}.flatten.sum
