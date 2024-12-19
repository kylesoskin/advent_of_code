
def is_possible(pattern, available_towels)
  pattern_size = pattern.size
  chars = pattern.chars
  combos = []
  (1..pattern_size).each do |i|
    str = chars.clone
    until str.empty? 
      combos << str.shift(i)
    end
  end

  # pp [combos, combos.uniq,available_towels]
  # gets

  min_s = combos.min_by(&:size).size
  max_s = combos.max_by(&:size).size
  all_combos = []
  (min_s..max_s).each do |i|
    all_combos = all_combos + combos.combination(i).to_a
  end
  # pp all_combos.select{|c| c.flatten.join == pattern}
  result = all_combos.select{|c| c.flatten.join == pattern && c.all?{|r| available_towels.include?(r)} }.count > 0 
  if result 
    return result
  else
    all_combos = []
    (min_s..max_s).each do |i|
      all_combos = all_combos + combos.permutation(i).to_a
    end
    return all_combos.select{|c| c.flatten.join == pattern && c.all?{|r| available_towels.include?(r)} }.count > 0 
  end
end

input  = File.read('sample_input.txt').lines.map(&:chomp)
available_towels = input.shift.split(",").map{|x| x.delete(' ').chars}
input.shift
patterns = input

@min_element_size = available_towels.min_by {|d| d.size}.size
@max_element_size = available_towels.max_by {|d| d.size}.size

pp patterns.map {|pattern|  
  [pattern, is_possible(pattern, available_towels)]
}