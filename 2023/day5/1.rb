all_lines = File.readlines('input.txt').map(&:chomp)
# all_lines = File.readlines('sample.txt').map(&:chomp)

class Seed
  attr_accessor :num
  def initialize(num)
    @num = num.to_i
  end

  def find_location(maps)
    soil = maps[0].mappings[@num] || @num
    fertilizer = maps[1].mappings[soil] || soil
    water = maps[2].mappings[fertilizer] || fertilizer
    light =  maps[3].mappings[water] || water
    temperature = maps[4].mappings[light] || light
    humidity = maps[5].mappings[temperature] || temperature
    location = maps[6].mappings[humidity] || humidity
    pp [soil, fertilizer, water, light, temperature, humidity, location]
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
    pp "Adding mapping: #{m}"
    dest_range, source_range, len = m.split(' ').map(&:to_i)
    dr = (dest_range..dest_range+len-1).to_a
    sr = (source_range..source_range+len-1).to_a
    (0..dr.length-1).each do |i|
      @mappings[sr[i]] = dr[i]
    end
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
