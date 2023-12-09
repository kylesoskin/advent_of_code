FILE = 'input.txt'
# FILE = 'sample.txt'
data = File.readlines(FILE).map{|l| l.chomp.split(' ').map{|x| x.to_i}}

class Array
  def map_delta
    collected_vals = []
    self.each.with_index do |v, i|
      next if i == 0
      collected_vals << (v - self[i-1])
    end
    collected_vals
  end
end

f_vals = []
data.each do |d| 
  curr_iter = d.map_delta
  collected_vals = [d, curr_iter]
  until curr_iter.all? {|x| x == 0}
    next_iter = curr_iter.map_delta
    collected_vals << next_iter.dup
    curr_iter = curr_iter.map_delta
  end

  collected_vals.last.prepend(0)
  reversed = collected_vals.reverse
  reversed.each.with_index do |v_arr, i|
    one_up = reversed[i+1]
    next if one_up.nil?
    val_to_add = one_up.first - v_arr.first
    one_up.prepend(val_to_add)
  end
  f_vals << collected_vals.first.first
  pp collected_vals
end

pp f_vals.sum