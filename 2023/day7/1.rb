FILE = 'input.txt'
# FILE = 'sample.txt'

TYPE_MAPPING = {
  high_card: 1,
  one_pair: 2,
  two_pair: 3,
  three_of_a_kind: 4,
  full_house: 5,
  four_of_a_kind: 6,
  five_of_a_kind: 7
}

FACE_CARD_MAP = {
  ?T => 10,
  ?J => 11,
  ?Q => 12,
  ?K => 13,
  ?A => 14
}

def card_val(c)
  v = FACE_CARD_MAP[c]
  v.nil? ? c.to_i : v
end

data = File.readlines(FILE).map{|l|
  cards, bid = l.chomp.split(' ')
  card_counts = cards.chars.tally
  case card_counts.count
  when 5
    card_class = :high_card
  when 4
    card_class = :one_pair
  when 3
    if card_counts.values.any? {|c| c == 3}
      card_class = :three_of_a_kind
    else
      card_class = :two_pair
    end
  when 2
    if card_counts.values.sort == [2,3]
      card_class = :full_house
    else
      card_class = :four_of_a_kind
    end
  when 1
    card_class = :five_of_a_kind
  else
    raise 'something is wrong'
  end
  {cards:, bid:, card_counts:, card_class:}
}

def next_lowest(selected)
  selected.min_by {|h| h[:cards].chars.map {|c| card_val(c)} }
end

sorted_by_type = data.sort_by {|h| TYPE_MAPPING[h[:card_class]]}
final_sort = []
TYPE_MAPPING.keys.each do |k|
  selected = sorted_by_type.select {|x| x[:card_class] == k}
  until selected.empty?
    nl = next_lowest(selected)
    final_sort << nl
    selected.delete(nl)
  end
end

# pp final_sort
pp final_sort.map.with_index {|h,i| ((i+1) * h[:bid].to_i) }.sum