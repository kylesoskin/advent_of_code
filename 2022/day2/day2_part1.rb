ENC_1 = {
  ?A => :rock,
  ?B => :paper,
  ?C => :scissors
}
ENC_2 = {
  ?X => :rock,
  ?Y => :paper,
  ?Z => :scissors
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
  p1, p2 = combo
  case 
  when p1 == p2 
    3 
  when BEATS[p2] == p1 
    6
  else
    0
  end
end

input = File.read('input.txt')
rounds = input.lines.map {|x| 
  split = x.split
  human_readable = [ENC_1[split.first], ENC_2[split.last]]
  result(human_readable) + SCORES[human_readable.last]
}
pp rounds.sum



