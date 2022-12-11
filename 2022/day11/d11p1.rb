class Monkey
  attr_accessor :items, :operation, :test_c, :test_t, :test_f, :monks, :num_inspected
  def initialize(m)
    @monks = []
    @num_inspected = 0
    @items = m.shift.chomp.split(?:).last.split(?,).map(&:to_i)
    @operation = m.shift.chomp.split(?:).last.split('=').last
    @test_c = last_to_i(m.shift)
    @test_t = last_to_i(m.shift)
    @test_f = last_to_i(m.shift)
  end

  def inspect_items!
    while i = @items.shift do
      @num_inspected += 1
      i = inspect_item(i)
      throw_to = test_worry_level(i) ? @test_t : @test_f
      @monks[throw_to].items << i
    end
  end

  private
  def last_to_i(m)
    m.chomp.split(' ').last.to_i
  end

  def inspect_item(old)
    old = eval(operation)
    old / 3
  end

  def test_worry_level(i)
    i % @test_c == 0
  end
end

@monks = []
def to_monke(monk_chonk)
  m = monk_chonk.lines
  m.shift if monk_chonk[0] == "\n"
  m.shift
  @monks << Monkey.new(m)  
end

TESTING = false
File.read(TESTING ? 'sample_input.txt' : 'input.txt').split(/^$/).each {|c| to_monke(c)}
@monks.each {|m| m.monks = @monks}
20.times do 
  @monks.each do |m|
    m.inspect_items!
  end
end

o,t = @monks.map{|m| m.num_inspected}.max(2)
puts o * t