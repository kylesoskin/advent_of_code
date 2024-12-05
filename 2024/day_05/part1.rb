def check_rules(update)
  errors = []
  update.each_with_index do |num, i|
    applicable_rules = @rules.select {|a| a[0] == num && update.include?(a[1])}
    req = applicable_rules.map(&:last)
    next if i==0
    offenders = (req & update[0..i])
    errors.concat(offenders) unless offenders.empty?
  end
  return errors.empty?
end

input = File.read('input.txt')

rules, updates = input.split(/^$/)
@rules = rules.lines.map {|r| r.chomp.split(?|)}
@updates = updates.lines.map {|r| r.chomp.split(?,)}.reject{|x| x.empty?}

pp @updates.select {|u| check_rules(u)}.map {|a| a[a.length/2].to_i}.sum