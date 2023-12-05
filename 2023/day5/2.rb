require 'set'

class Seed
  attr_accessor :num

  def initialize(num)
    @num = num.to_i
  end

  def map_eval(i, n, maps)
    m1, m2 = maps[i].mappings.find { |sr, dr| sr.first <= n && n < sr.last }
    m1.nil? || m2.nil? ? n : (n - m1.first) + m2.first
  end

  def find_location(maps)
    location = @num

    (0..6).each do |i|
      location = map_eval(i, location, maps)
    end

    location
  end
end

class AlmanacMap
  attr_accessor :mappings

  def initialize(heading)
    # @source_type, _, @dest_type = heading.split(' ').first.split(?-)
    @mappings = {}
  end

  def add_to_mapping(m)
    dest_range, source_range, len = m.split(' ').map(&:to_i)
    dr = (dest_range..dest_range + len - 1)
    sr = (source_range..source_range + len - 1)
    @mappings[sr] = dr
  end
end

def read_maps(filename)
  all_lines = File.readlines(filename, chomp: true)
  seeds_data, *maps_data = all_lines

  seeds = seeds_data.split(?:).last.split(' ').each_slice(2).map { |v| (v[0].to_i..v[0].to_i + v[1].to_i - 1) }
  maps = []

  current_map = nil
  maps_data.each do |l|
    case l
    when /^\d/
      current_map.add_to_mapping(l)
    when /^\w/
      map = AlmanacMap.new(l)
      current_map = map
      maps << map
    end
  end

  [seeds, maps]
end

def find_lowest_location(seeds, maps)  
  results = []
  t = []
  seeds.each_with_index do |s, index|    
    t << Thread.new {
      lowest = nil
      puts "(#{index}/#{seeds.size - 1})::#{Time.now}:: Working seeds in range: #{s} (#{s.last - s.first})"
      s.each do |n|
        location = Seed.new(n).find_location(maps)
        lowest = location if lowest.nil? || location < lowest
      end
      results << lowest
    }
  end
  t.map(&:join)
  results
end

input_filename = 'sample.txt'
seeds, maps = read_maps(input_filename)
lowest_location = find_lowest_location(seeds, maps)
puts lowest_location.min
