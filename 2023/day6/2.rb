race_duration, record_distance = File.readlines('input.txt').map{|l| l.scan(/\d/).join.to_i}


(0..race_duration).map {|holding_button| 
  remaining_duration = race_duration - holding_button
  remaining_duration * holding_button
}.select {|distance| distance > record_distance}.count
