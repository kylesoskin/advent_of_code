arr = File.read('input.txt').chars.each_slice(4).to_a
pp arr.find {|x| x.uniq == x}
pp arr[0...arr.find_index {|x| x.uniq == x}].flatten.count + 1
