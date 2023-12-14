data = File.readlines(ENV['FILE']).map {|l| l.chomp.chars}
ROUND_ROCK = "O"
EMPTY_SPACE = "."

def shift_north(data)
  num_moves = nil
  until num_moves == 0
    num_moves = 0
    (1..data.size-1).each do |y|
      (0..data.size-1).each do |x|
        curr_rock = data[y][x]
        above_val = data[y-1][x]
        if curr_rock == ROUND_ROCK && above_val == EMPTY_SPACE      
          data[y-1][x] = ROUND_ROCK
          data[y][x] = EMPTY_SPACE
          num_moves += 1
        end
      end
    end
  end
  data
end


pp shift_north(data).map.with_index {|row, i| row.count(ROUND_ROCK) * (data.count-i)}.sum