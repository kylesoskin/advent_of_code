@input = File.read('sample_input.txt').lines.map {|l| l.chomp.chars}
@input = File.read('input.txt').lines.map {|l| l.chomp.chars}

def find_start
  @input.each_with_index do |row, r|
    row.each_with_index do |val, c|
      return [r, c] if val == '^'
    end
  end
end

def shift_90
  case @heading
  when :up
    @heading = :right
  when :down
    @heading = :left
  when :left
    @heading = :up
  when :right
    @heading = :down
  end
end

def move
  next_row, next_col = next_pos
  @cur_row = next_row
  @cur_col = next_col
  @input[@cur_row][@cur_col] = "X"
end

def next_pos
  case @heading
  when :up
    [@cur_row-1, @cur_col]
  when :down
    [@cur_row+1, @cur_col]
  when :left
    [@cur_row, @cur_col-1]
  when :right
    [@cur_row, @cur_col+1]
  end
end

def next_val
  next_row, next_col = next_pos
  return nil if next_row > @input.size-1 || next_col > @input.first.size-1 || next_col.negative? || next_row.negative?
  @input[next_row][next_col]
rescue 
  return nil
end

@cur_row, @cur_col = find_start
@heading = :up
@done = false

until @done
  n = next_val
  if n.nil?
    @done = true
  else
    if n == "." || n == "X" || n == "^"
      move
    else
      shift_90 
    end
  end
end

puts @input.map(&:join).join("\n")
pp @input.map {|x| x.count("X") + x.count("^")}.sum
