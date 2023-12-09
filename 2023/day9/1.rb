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

  # pp collected_vals;exit
  collected_vals.last << 0
  reversed = collected_vals.reverse
  reversed.each.with_index do |v_arr, i|
    one_up = reversed[i+1]
    next if one_up.nil?
    val_to_add = v_arr.last + one_up.last
    one_up << val_to_add 
  end
  f_vals << collected_vals.first.last
end
pp f_vals.sum