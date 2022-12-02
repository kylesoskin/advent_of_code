ENC_1 = {
  ?A => :rock,
  ?B => :paper,
  ?C => :scissors
}
ENC_2 = {
  ?X => 0,
  ?Y => 3,
  ?Z => 6
}
SCORES = {
  rock: 1,
  paper: 2,
  scissors: 3
}
BEATS = {
  rock: :scissors,
  paper: :rock,
  scissors: :paper
}

def result(combo) 
  p1, wld = combo
  choosen = case wld
  when 3
    SCORES[p1]
  when 0
    SCORES[BEATS[p1]]
  when 6
    SCORES[BEATS.invert[p1]]
  end
  choosen + wld
end

input = File.read('input.txt')
rounds = input.lines.map {|x| 
  split = x.split
  human_readable = [ENC_1[split.first], ENC_2[split.last]]
  result(human_readable)
}
pp rounds.sum
# Result: 13490


