# frozen_string_literal: true

def blink(stone_val,i)
  pv = @cache[stone_val][i] rescue nil
  unless pv.nil?  
    return pv 
  end
  if stone_val.is_a?(Array)
    return stone_val.map{|d| blink(d,i)}
  end
  new_val = nil
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
  @cache[stone_val]||={}
  @cache[stone_val][i] ||= new_val
  new_val
end

@cache = {}
@cache2 = {}
def do_blinks(input, blink_count)  
  (0..blink_count-1).each do |i| 
    input.map! { |x| 
      r = @cache2[[x,i]]||blink(x,i)
      s = [r].flatten
      @cache2[[x,i]] ||= s
      s
    }
    pp [@cache.keys.count, @cache2.keys.count]
  end
  
  input.flatten.count
end

input = File.read('sample_input.txt').lines[0].chomp.split(' ').map(&:to_i)

pp do_blinks(input, 25)
