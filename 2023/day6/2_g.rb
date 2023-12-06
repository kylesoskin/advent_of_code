x, y = File.readlines('input.txt').map{|l| l.scan(/\d/).join.to_i}
p (0..x).map {|z| (x - z) * z}.select {|q| q > y}.size