require 'set'
all_lines = File.readlines('input.txt').map(&:chomp)
# all_lines = File.readlines('sample.txt').map(&:chomp)

class Seed
  attr_accessor :num
  def initialize(num)
    @num = num.to_i
  end

  def map_eval(i, n, maps)
    m1, m2 = maps[i].mappings.find {|sr, dr| sr.first <= n && n < sr.last}
    if m1.nil? || m2.nil?
      n
    else
      (n - m1.first) + m2.first 
    end
  end

  def find_location(maps)
    soil = map_eval(0, @num, maps)
    fertilizer = map_eval(1, soil, maps)
    water = map_eval(2, fertilizer, maps)
    light =   map_eval(3, water, maps)
    temperature =  map_eval(4, light, maps)
    humidity =  map_eval(5, temperature, maps)
    location =  map_eval(6, humidity, maps)
    location
  end

end

class AlmanacMap
  attr_accessor :source_type, :dest_type, :mappings
  def initialize(heading)
    @source_type, _, @dest_type = heading.split(' ').first.split(?-)
    @mappings = {}
  end

  def add_to_mapping(m)
    dest_range, source_range, len = m.split(' ').map(&:to_i)
    dr = (dest_range..dest_range+len-1)
    sr = (source_range..source_range+len-1)
    @mappings[sr] = dr
  end
end

seeds = all_lines.shift.split(?:).last.split(' ').each_slice(2).to_a.map {|v| (v[0].to_i .. v[0].to_i+v[1].to_i-1)}
maps = []
current_map = nil
all_lines.each do |l|
  case l
  when /^\d/
    current_map.add_to_mapping(l)
  when /^\w/
    map = AlmanacMap.new(l)
    current_map = map
    maps << map
  end
end

lowest = nil
sn = seeds.count-1
c = 0
seeds.each do |s| 
  puts "(#{c}/#{sn})::#{Time.now}:: Working seeds in range: #{s} (#{s.last - s.first})"
  s.each do |n|
    location = Seed.new(n).find_location(maps)
    lowest = location if lowest.nil?
    lowest = location if location < lowest
  end
  c+=1
end
pp lowest
