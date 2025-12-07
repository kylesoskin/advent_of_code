# frozen_string_literal: true

# input = 'sample_input.txt'
input = 'input.txt'

EMPTY = '.'
TAYCHON = '|'
SPLITTER = '^'

@data = File.readlines(input, chomp: true).map(&:chars)

splits = 0
line = 0
start_index = @data.first.index('S')
@tachyons = Set.new
@tachyons << start_index

until line >= @data.size - 1
  @tachyons.dup.each do |t|
    n_char = @data[line + 1][t]
    if n_char == EMPTY # && not_doing_next_iter.include?(t)
      @data[line + 1][t] = TAYCHON
    elsif n_char == SPLITTER
      @tachyons << t - 1
      @tachyons << t + 1
      @data[line + 1][t - 1] = TAYCHON
      @data[line + 1][t + 1] = TAYCHON
      # pp "Deleting #{t}"
      @tachyons.delete(t)
    end
    # system "clear"
    # puts @data.map(&:join).join("\n")
    # gets
  end
  line += 1
end

@data.each.with_index do |row, i|
  row.each.with_index do |char, j|
    splits += 1 if (char == SPLITTER) && (@data[i - 1][j] == TAYCHON)
  end
end
pp splits
