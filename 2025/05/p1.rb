# frozen_string_literal: true

# input = 'sample_input.txt'
input = 'input.txt'

data = File.read(input).split("\n")

# Get fresh ranges
fresh_list = Set.new
range = nil
until range == ''
  range = data.shift
  unless range == ''
    b, e = range.split('-').map(&:to_i)
    fresh_list << (b..e)
  end
end

pp(data.count do |d|
  fresh_list.any? { |f| f.include?(d.to_i) }
end)
