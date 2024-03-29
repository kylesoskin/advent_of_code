DIGITS = {
  one: 1,
  two: 2,
  three: 3,
  four: 4, 
  five: 5, 
  six: 6, 
  seven: 7, 
  eight: 8, 
  nine: 9
}.map {|k,v| [k.to_s, v.to_s]}.to_h

def replace_digits(str)
  has_words = DIGITS.keys.map {|word| [word, str =~ /#{word}/]}.reject{|a| a.last.nil?}
  unless has_words.empty? 
    ordered_occurring_digit_word = has_words.sort_by {|a| a.last}.first.first
    str.sub!(ordered_occurring_digit_word, DIGITS[ordered_occurring_digit_word])
    replace_digits(str)
  end
  str
end

puts File.read('input.txt').lines.map{|l|
  chars = replace_digits(l).chars.select {|c| c =~ /[0-9]/}
  [chars[0], chars[-1]].join.to_i
}.sum