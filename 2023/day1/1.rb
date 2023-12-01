puts File.read('input.txt').lines.map{|l|
  chars = l.chars.select {|c| c =~ /[0-9]/}
  [chars[0], chars[-1]].join.to_i
}.sum