data = File.readlines('input.txt')
# data = File.readlines('sample.txt')

pp data.map {|line|
  _, card = line.split(?:)
  winning, have = card.split(?|).map {|v| v.split(" ").map(&:to_i)}
  matches = have & winning
  points = 2**(matches.count-1)
  points >= 1 ? points : 0
}.sum