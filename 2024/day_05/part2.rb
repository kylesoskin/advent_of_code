# frozen_string_literal: true

input = File.read('input.txt')
rules, updates = input.split(/^$/)
@rules = rules.lines.map { |r| r.chomp.split('|') }
@updates = updates.lines.map { |r| r.chomp.split(',') }.reject(&:empty?)
to_sum = []

def check_rules(update)
  errors = []
  update.each_with_index do |num, i|
    applicable_rules = @rules.select { |a| a[0] == num && update.include?(a[1]) }
    req = applicable_rules.map(&:last)
    next if i.zero?

    offenders = (req & update[0..i])
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
  u.dup
  errors = check_rules(u)
  errors.dup
  next if errors.empty?

  until errors.empty?
    u = cycle_and_return(u)
    errors = check_rules(u)
  end
  to_sum << u[u.size / 2].to_i
end
pp to_sum.sum
