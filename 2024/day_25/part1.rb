INPUT = 'input.txt'

input = File.read(INPUT).split(/^$/).map(&:lines)

def display(r)
  puts r
  puts "="*20
end

LOCK_HEIGHT = 6
KEY_LENGTH  = 5

def lock_pin_heights(l)
  (0..KEY_LENGTH-1).map do |i|
    l.map {|q| q[i]}.count(?#)-1
  end
end
def key_pin_heights(k)
  (0..KEY_LENGTH-1).map do |i|
    5 - (k.map {|q| q[i]}.count(?.)-1)
  end
end
def is_lock(r)
  r.first.chomp.chars.all?{|e| e==?#}
end

keys = []
locks = []
input.each do |r|
  r.shift if r.first =~ /^$/
  if is_lock(r)    
    lh = lock_pin_heights(r)
    locks << lh
  else
    k = key_pin_heights(r)
    keys << k
  end
end
res = []
locks.each do |lock|
  keys.each do |key|
    overlap = (0..4).any?{|i| lock[i] + key[i] > 5}
    res << [lock, key, overlap]
  end
end
pp res.count{|d| d.last == false}