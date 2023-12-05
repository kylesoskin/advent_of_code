all_lines = File.readlines('input.txt').map(&:chomp)
# all_lines = File.readlines('sample.txt').map(&:chomp)

class Seed
  attr_accessor :num
  def initialize(num)
    @num = num.to_i
  end

  def map_eval(i, n, maps)
    map = maps[i].mappings.find {|sr, dr| sr.include?(n)}
    if map.nil?
      n
    else
      offset = (n - map[0].first)
      offset + map[1].first 
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
    # pp [soil, fertilizer, water, light, temperature, humidity, location]
    location
  end

end

class AlmanacMap
  attr_accessor :mappings#,:source_type, :dest_type, 
  def initialize(heading)
    # @source_type, _, @dest_type = heading.split(' ').first.split(?-)
    @mappings = {}
  end

  def add_to_mapping(m)
    dest_range, source_range, len = m.split(' ').map(&:to_i)
    dr = (dest_range..dest_range+len-1)
    sr = (source_range..source_range+len-1)
    @mappings[sr] = dr
  end
end

seeds = all_lines.shift.split(?:).last.split(' ').map{|s| Seed.new(s)}
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

pp seeds.map{|s| s.find_location(maps)}.min
