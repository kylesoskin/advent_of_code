RED_MAX = 12
GREEN_MAX = 13
BLUE_MAX = 14

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

def game_passes(game) 
  (game['red']   || 0) <= RED_MAX &&
  (game['green'] || 0) <= GREEN_MAX && 
  (game['blue']  || 0) <= BLUE_MAX 
end

passed = []
File.readlines('input.txt').each do |l|
  split = l.split(?:)
  id = split.shift.split(' ').last.to_i
  sets = split.last.split(?;)
  mapped = sets.map(&:set_to_numbers)
  passed << id if mapped.all? {|g| game_passes(g)}
end

pp passed.sum