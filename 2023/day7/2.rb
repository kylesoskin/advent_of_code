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
  ?J => 1,
  ?Q => 12,
  ?K => 13,
  ?A => 14
}

def card_val(c)
  v = FACE_CARD_MAP[c]
  v.nil? ? c.to_i : v
end
def max_with_j(cards)  
  t =  (cards.chars - ["J"]).tally.max_by{|k,v| v}
  if t.nil?
    cards
  else 
    replace_card = (cards.chars - ["J"]).tally.max_by{|k,v| v}.first
    cards.gsub(/J/, replace_card)
  end
end

data = File.readlines(FILE).map{|l|
  cards, bid = l.chomp.split(' ')
  replaced_cards = cards
  if cards =~ /J/
    replaced_cards = max_with_j(cards) 
  end
  card_counts = replaced_cards.chars.tally
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
  {cards:, bid:, card_counts:, card_class:, replaced_cards:}
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

pp final_sort

# pp final_sort
pp final_sort.map.with_index {|h,i| ((i+1) * h[:bid].to_i) }.sum