require 'pry'
class Monkey
  attr_accessor :secret
  def initialize(num)
    @secret = num
  end

  def mix(sn, result)
    sn ^ result
  end

  def prune(sn)
    sn % 16777216
  end

  def evolve
    @secret = prune( mix(@secret, @secret * 64))
    @secret = prune( mix(@secret, @secret / 32))
    @secret = prune( mix(@secret, @secret * 2048))
    @secret
  end

  def take(n)
    arr = []
    n.times {
      arr << evolve
    }
    arr
  end

  def last_digits(a)
    a.map {|d| d%10 }
  end

  def take_deltas(n)
    vs = last_digits( [@secret] + take(n) )
    (0..(vs.size-2)).map {|i| 
      [vs[i+1], vs[i+1] - vs[i]]
    }
  end

  def val_after(n)
    n.times {
      evolve
    }
    @secret
  end
end

INPUT_FILE = 'input.txt'
ITERS = 2000
monks = File.read(INPUT_FILE).lines.map{|l| l.chomp.to_i}

def delta_possibles(a)
  all = {}
  (0..a.size-1).each do |i|
    seq = a[i..i+3]
    next unless seq.size == 4
    delta_seq = seq.map(&:last)    
    max = seq.map(&:first).max
    all[delta_seq] ||= max
  end
  all
end


all = monks.map {|m| 
  possible_and_vals = Monkey.new(m).take_deltas(ITERS)
  delta_possibles(possible_and_vals)
}
possible_seqs = all.map{|k| k.keys}.flatten(1).uniq

pp possible_seqs.map {|s|
  v = all.map {|m| m[s]||0}
  [s, v, v.sum ]
}.sort_by(&:last).last.last