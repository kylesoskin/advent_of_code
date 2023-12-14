data = File.read(ENV['FILE']).split(/[\r\n]\n/).map {|l| l.lines.map{|f| f.chomp.chars} }

def rows_above(data)
  (1..data.size-1).find {|i|
    (1..([i, data.size-i].min)).all? {|j| data[i - j] == data[i + j - 1]}
  } 
end

pp data.map {|d| {above: rows_above(d), left: rows_above(d.transpose)}}.map.with_index {|h,i|
  res = h.reject {|k,v| v.nil?}  
  (res[:above] || 0) * 100 + (res[:left] || 0)
}.sum