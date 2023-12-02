class String
  def set_to_numbers
    h = {}
    self.split(?,).each do |x|
      num, color = x.strip.split
      h[color] = num.to_i
    end  
    h
  end
end
all = []
File.readlines('input.txt').each do |l|
  split = l.split(?:)
  id = split.shift.split(' ').last.to_i
  sets = split.last.split(?;)
  mapped = sets.map(&:set_to_numbers)
  h = {}
  mapped.each do |game|    
    game.each do |color, num|
      h[color] ||= []
      h[color] << num
    end
  end
  all << h.values.map(&:max).inject(&:*)
end
pp all.sum
