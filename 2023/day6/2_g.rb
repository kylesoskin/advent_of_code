t, d = File.readlines('input.txt').map(&:chomp)
p {t.split(?:).last.delete(' ').to_i => d.split(?:).last.delete(' ').to_i}.map{|x, y| (0..x).map {|z| (x - z) * z}.select {|q| q > y}.size}.inject(&:*)