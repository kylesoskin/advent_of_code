SCORES = {
  ?X => 1,
  ?Y => 2,
  ?Z => 3
}
BEATS = {
  ?X => ?Z,
  ?Y => ?X,
  ?Z => ?Y
}
ENC = {
  ?A => ?X,
  ?B => ?Y,
  ?C => ?Z
}

puts File.read('input.txt').lines.map {|x| 
  p1, p2 =  x.split
  ((p1 = ENC[p1]) == p2 ? 3 : (BEATS[p2] == p1 ? 6 : 0)) + SCORES[p2]
}.sum
# Result: 17189


