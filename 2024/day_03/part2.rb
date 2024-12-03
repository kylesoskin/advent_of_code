# frozen_string_literal: true

input = 'input.txt'
# input = 'sample_input2.txt'
input = File.read(input)

def sum_multiples(str)
  str.scan(/mul\(\d*,\d*\)/).map { |d| d.tr('mul()', '').split(',').map(&:to_i).inject(:*) }.sum
end

sum = 0
done = false
until done
  dont = input.index("don't()")
  if dont.nil?
    sum += sum_multiples(input)
    done = true
  else
    sum += sum_multiples(input[0..dont])
    input = input[dont + 1..]
    do_loc = input.index('do()')
    input = input[do_loc..]
  end
end
pp sum
