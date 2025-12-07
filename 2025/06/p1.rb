# frozen_string_literal: true

# input = 'sample_input.txt'
input = 'input.txt'

data = File.read(input).split("\n")
flip = []
data.each do |line|
  split = line.split(' ')
  split.each.with_index do |v, i|
    flip[i] ||= []
    flip[i] << v
  end
end
def mult(d)
  d.inject(1) { |prod, n| prod * n }
end

pp flip.map { |d|
  op = d.pop
  d.map!(&:to_i)
  op == '+' ? d.sum : mult(d)
}.sum
