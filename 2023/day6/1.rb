times, distances = File.readlines('input.txt').map(&:chomp)
h = Hash[times.split(':').last.split(" ").map(&:to_i).zip(distances.split(':').last.split(" ").map(&:to_i))]

p h.map{|race_duration, record_distance|
  (0..race_duration).map {|holding_button| 
    remaining_duration = race_duration - holding_button
    remaining_duration * holding_button
  }.select {|distance| distance > record_distance}.count
}.inject(&:*)