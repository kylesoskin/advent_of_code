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

hashmap = (0..255).map {|i| [i, []]}.to_h

data[0].split(?,).each {|str| 
  
  if str =~ /-/
    label = str.delete(?-)
    hval = val_of_str(label)
    hashmap[hval].delete_if {|x| x[:label] == label}
  else
    label, fl = str.split(?=)
    hval = val_of_str(label)
    if (i=hashmap[hval].find_index {|x| x[:label] == label})
      hashmap[hval][i][:fl] = fl
    else
      hashmap[hval] << {label:, fl:}
    end
  end
}
val = 0
hashmap.reject {|k,v| v.empty?}.each do |box, box_contains|
  box_contains.each_with_index.each do |h, slot|
    val += [box+1, slot+1, h[:fl].to_i].reduce(&:*)
  end
end

pp val