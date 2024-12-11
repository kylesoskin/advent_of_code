# frozen_string_literal: true

def single_num_transform(stone_val)
  if stone_val.is_a?(Array)
    return stone_val.map{|d| single_num_transform(d)}
  end
  chrs = stone_val.to_s.chars
  chrs_count = chrs.count
  if stone_val.zero?
    new_val = 1
  elsif chrs_count.even?
    chrs_mid = chrs_count / 2
    l = chrs[0..chrs_mid - 1].join.to_i
    r = chrs[chrs_mid..].join.to_i
    new_val = [l, r]
  else
    new_val = 2024 * stone_val.to_i
  end
  return new_val
end

# gets single val hash
def check_cache(d)
  catch_hit = @cache[d]
  if catch_hit.nil?
    result = single_num_transform(d)
    @cache[d] = result
  else
    @cache[d] = catch_hit    
  end
end

input = File.read('sample_input.txt').lines[0].chomp.split(' ').map(&:to_i)
@blink_count=6
c = 0
@cache = {}

def dive(num,depth)
  rtable = {}
  result = [num]
  (0..depth).each {|i|
    result = result.map {|d| result[d]||single_num_transform(d)}.flatten
    rtable[i] = result
    # pp rtable
  }
  rtable
end

expanded_mapping = input.map {|num| 
 dive(num, @blink_count)
}

