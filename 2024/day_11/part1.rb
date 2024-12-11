# frozen_string_literal: true

def blink(stone_val)
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
  new_val
end

input = File.read('input.txt').lines[0].chomp.split(' ').map(&:to_i)
blink_count = 25
blink_count.times do
  input.map! { |x| blink(x) }.flatten!
end
pp input.count
