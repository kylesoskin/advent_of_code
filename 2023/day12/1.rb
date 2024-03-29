FILE = 'input.txt'
data = File.readlines(FILE).map{|l| l.chomp.split(' ')}

def find_indexes_of(char, str)
  (str.is_a?(Array) ? str : str.chars).map.with_index {|c,i| c == char ? i : nil}.compact
end

def find_chunks_from_indexes(indexes)
  chunks = []
  seg_count = 0
  indexes.each.with_index do |v, i|
    next_index = indexes[i+1]
    if next_index.nil? || ((next_index - v) == 1)
      seg_count += 1
    else      
      seg_count += 1
      chunks << seg_count
      seg_count = 0
    end
  end  
  chunks << seg_count
  chunks.join(?,)
end

def all_combos(str)
  # Original, kinda slow
  # op_locked = find_indexes_of(?., str)
  # broke_locked = find_indexes_of(?#, str)
  # [?.,?#].repeated_permutation(str.size).select {|perm|
  #   perm.select.with_index {|v,i| op_locked.include?(i) }.all? {|c| c == ?.} && 
  #   perm.select.with_index {|v,i| broke_locked.include?(i) }.all? {|c| c == ?#}
  # }
  # Faster
  unknowns = str.count(??)
  all_possible = [?.,?#].repeated_permutation(unknowns)
  positions = find_indexes_of(??, str)
  all_possible.map {|posible_vals| 
    ns = str.clone    
    posible_vals.each.with_index do |v, i|
      ns[positions[i]] = v
    end
    ns
  }
end


pp data.map {|row|
  pp ["on row", row, row[0].size]
  spring_conditions, ordering = row
  c = all_combos(spring_conditions).map {|s| 
    idxs = find_indexes_of(?#, s)
    find_chunks_from_indexes(idxs)
  }.count {|x| x == ordering}
}.sum