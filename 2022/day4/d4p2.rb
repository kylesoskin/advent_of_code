p File.read('input.txt').lines.map {|l|
  o,t = l.split(?,)
  r1,r2 = o.split(?-)
  p1,p2 = t.chomp.split(?-)
  r = (r1.to_i..r2.to_i).to_a
  p = (p1.to_i..p2.to_i).to_a
  (r & p)
}.count{|x| x.any?}