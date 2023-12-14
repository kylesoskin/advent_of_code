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
        north_val = data[y-1][x]
        if curr_rock == ROUND_ROCK && north_val == EMPTY_SPACE      
          data[y-1][x] = ROUND_ROCK
          data[y][x] = EMPTY_SPACE
          num_moves += 1
        end
      end
    end
  end
  data
end
def shift_west(data)
  num_moves = nil
  until num_moves == 0
    num_moves = 0
    (0..data.size-1).each do |y|
      (1..data.size-1).each do |x|
        curr_rock = data[y][x]
        west_val = data[y][x-1]
        if curr_rock == ROUND_ROCK && west_val == EMPTY_SPACE      
          data[y][x-1] = ROUND_ROCK
          data[y][x] = EMPTY_SPACE
          num_moves += 1
        end
      end
    end
  end
  data
end
def shift_east(data)
  num_moves = nil
  until num_moves == 0
    num_moves = 0
    (0..data.size-1).each do |y|
      (0..data.size-2).each do |x|
        curr_rock = data[y][x]
        east_val = data[y][x+1]
        if curr_rock == ROUND_ROCK && east_val == EMPTY_SPACE      
          data[y][x+1] = ROUND_ROCK
          data[y][x] = EMPTY_SPACE
          num_moves += 1
        end
      end
    end
  end
  data
end
def shift_south(data)
  num_moves = nil
  until num_moves == 0
    num_moves = 0
    (0..data.size-2).each do |y|
      (0..data.size-1).each do |x|
        curr_rock = data[y][x]
        south_val = data[y+1][x]
        if curr_rock == ROUND_ROCK && south_val == EMPTY_SPACE      
          data[y+1][x] = ROUND_ROCK
          data[y][x] = EMPTY_SPACE
          num_moves += 1
        end
      end
    end
  end
  data
end

def cycle(data, count)
  count.times {
    shift_north(data)
    shift_west(data)
    shift_south(data)
    shift_east(data)
  }
  data
end

factor = 1000
pp (cycle(data, factor)).map.with_index {|row, i| row.count(ROUND_ROCK) * (data.count-i)}.sum
