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


pp monks.map {|m| 
  Monkey.new(m).val_after(ITERS)
}.sum
