all_lines = File.readlines('input.txt').map(&:chomp)
# all_lines = File.readlines('sample.txt').map(&:chomp)

times, distances = all_lines

t = times.split(':').last.split(" ").map(&:to_i)
d = distances.split(':').last.split(" ").map(&:to_i)
h = Hash[t.zip(d)]

pp h.map{|race_duration, record_distance|
  pp "race duration: #{race_duration}, record_distance #{record_distance}"
  pp (0..race_duration).map {|holding_button| 
    remaining_duration = race_duration - holding_button
    total_distance = remaining_duration * holding_button
    total_distance
  }.select {|distance| distance > record_distance}.count
}.inject(&:*)