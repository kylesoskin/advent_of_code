# input = File.read('input.txt')
# Part 1, one-liner
puts File.read('input.txt').split(/\n{2,}/).map {|x| x.lines.map{|z| z.chomp.to_i}.sum}.max

# Part 2, one-liner
puts File.read('input.txt').split(/\n{2,}/).map {|x| x.lines.map{|z| z.chomp.to_i}.sum}.max(3).sum


