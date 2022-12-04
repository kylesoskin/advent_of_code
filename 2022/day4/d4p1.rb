pp File.read('input.txt').lines.map {|l|
  o,t = l.split(?,)
  r1,r2 = o.split(?-)
  p1,p2 = t.chomp.split(?-)
  r = (r1.to_i..r2.to_i)
  p = (p1.to_i..p2.to_i)
  s,l = [p,r].sort_by{|a| a.to_a.length}
  l.cover?(s)
}.count {|x| x }