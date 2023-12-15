data = File.readlines(
  'input.txt'
).map {|l| l.chomp}


def val_of_str(str)
  val = 0
  str.chars.each do |c| 
    val += c.ord
    val = val * 17
    val = val % 256
  end
  val
end


pp data[0].split(?,).map {|str| val_of_str(str)}.sum