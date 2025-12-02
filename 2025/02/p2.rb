# frozen_string_literal: true

# input = 'sample_input.txt'
input = 'input.txt'
EMPTY = ''

def get_substrings(chars)
  i = 0
  j = 0
  all = Set.new
  (0..chars.size - 2).each do
    (0..chars.size - 2).each do
      all << chars[i..j]
      j += 1
    end
    i += 1
  end
  all
end

def invalid?(num)
  str = num.to_s
  get_substrings(str.chars).any? do |substr|
    str.split(substr.join.to_s).empty?
  end
end

pp File.read(input).lines.first.split(',').map { |r|
  s, e = r.split('-')
  (s.to_i..e.to_i).select { |x| invalid?(x) }
}.flatten.uniq.sum
