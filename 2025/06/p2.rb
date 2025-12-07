# frozen_string_literal: true

# input = 'sample_input.txt'
input = 'input.txt'

data = File.read(input).split("\n")
flip = []
data.each do |line|
  line.each_char.with_index do |char, i|
    flip[i] ||= []
    flip[i] << char
  end
end

def mult(d)
  d.inject(1) { |prod, n| prod * n }
end

def rechunk(flip)
  i = 0
  results = []
  until flip.empty?
    results[i] ||= []
    curr = flip.shift
    if curr.all? { |d| d == ' ' }
      i += 1
    else
      results[i] << curr
    end
  end
  cum_sum = 0
  results.each do |row|
    op = row.find { |r| r.any? { |c| c == '+' } } ? :add : :mult
    final_vals = row.map! { |r| r.reject { |c| ['+', '*', ' '].include?(c) }.join.to_i }
    cum_sum += op == :add ? final_vals.sum : mult(final_vals)
  end
  cum_sum
end

pp rechunk(flip)
