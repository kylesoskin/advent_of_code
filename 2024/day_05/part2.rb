# frozen_string_literal: true

input = File.read('input.txt')
# input = File.read('sample_input.txt')
rules, updates = input.split(/^$/)
@rules = rules.lines.map { |r| r.chomp.split('|') }
@updates = updates.lines.map { |r| r.chomp.split(',') }.reject(&:empty?)
to_sum = []

@rule_hash = {}
@rules.each do |r|
  x = r[0]
  @rule_hash[x] ||= []
  @rule_hash[x] << r[1]
end

def check_rules(update)
  errors = []
  update.each_with_index do |num, i|
    next if i.zero? || @rule_hash[num].nil?

    offenders = (@rule_hash[num] & update[0..i])
    errors.concat(offenders) unless offenders.empty?
  end
  errors
end

def cycle_and_return(u, to_move = 1)
  results = check_rules(u)
  return u if results.empty?

  historical = {}
  results.each do |r|
    needs_moved_index = u.index(r)
    historical[needs_moved_index] ||= []
    historical[needs_moved_index] << r
    u = cycle_and_return(u, to_move + 1) if historical[needs_moved_index].include?(u[needs_moved_index + to_move])
    return u if u[needs_moved_index + to_move].nil?

    u[needs_moved_index], u[needs_moved_index + to_move] = u[needs_moved_index + to_move], u[needs_moved_index]
  end
  u
end

@updates.each do |u|
  errors = check_rules(u)
  next if errors.empty?

  until errors.empty?
    u = cycle_and_return(u)
    errors = check_rules(u)
  end
  to_sum << u[u.size / 2].to_i
end
pp to_sum.sum
