# frozen_string_literal: true

# input = 'sample_input.txt'
input = 'input.txt'

data = File.read(input).split("\n")

# Get fresh ranges
fresh_list = Set.new
range = nil
until range == ''
  range = data.shift
  unless range == ''
    b, e = range.split('-').map(&:to_i)
    fresh_list << [b, e]
  end
end

range_list = fresh_list.map do |f|
  start_val = f[0]
  end_val = f[1]
  range = (start_val..end_val)
  range_count = range.count
  {
    start_val:, end_val:, range:, range_count:
  }
end
sorted_data = range_list.sort_by { |r| r[:start_val] }
chunks = []
sorted_data.each do |d|
  found_existing_start_chunk = chunks.index { |c| c.include?(d[:start_val]) }
  found_existing_end_chunk = chunks.index { |c| c.include?(d[:end_val]) }

  if !found_existing_end_chunk && !found_existing_start_chunk
    chunks << (d[:start_val]..d[:end_val])
  elsif found_existing_start_chunk
    chunks[found_existing_start_chunk] =
      ([d[:start_val],
        chunks[found_existing_start_chunk].first].min..[d[:end_val], chunks[found_existing_start_chunk].last].max)
  elsif found_existing_end_chunk
    chunks[found_existing_end_chunk] =
      ([d[:start_val],
        chunks[found_existing_start_chunk].first].min..[d[:end_val], chunks[found_existing_start_chunk].last].max)
  end
end
pp chunks.map(&:count).sum
