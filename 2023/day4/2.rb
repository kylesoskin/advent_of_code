data = File.readlines('input.txt')

@original_tickets = data.map.with_index {|line, index|
  _, card = line.split(?:)
  winning, have = card.split(?|).map {|v| v.split(" ").map(&:to_i)}
  matches = have & winning
  {
    match_count: matches.count, 
    original_index: index
  }
}

def find_new(ticket)
  @original_tickets[ticket[:original_index]+1 .. ticket[:original_index]+ticket[:match_count]] || [] 
end

ticket_counts = {}
ticket_indexes = (0..@original_tickets.count-1)
ticket_indexes.each {|c| ticket_counts[c] = 1}

to_do = @original_tickets.clone
until to_do.empty?
  next_ones = []
  to_do.each do |ticket|
    next_ones += find_new(ticket).each {|t| ticket_counts[t[:original_index]] += 1}
  end
  to_do = next_ones
  pp to_do.size
end

pp ticket_counts
pp ticket_counts.values.sum