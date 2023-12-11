FILE = 'input.txt'
# FILE = 'sample.txt'
# FILE = 'sample2.txt'

class Matrix
  attr_accessor :matrix, :path, :been_to
  attr_reader :start_pos

  SOUTH = [0,1]
  NORTH = [0,-1]
  WEST  = [1,0]
  EAST  = [-1,0]

  TOUCH_MAPPINGS = {
    ?| => [NORTH, SOUTH],
    ?- => [EAST, WEST],
    ?L => [NORTH, EAST],
    ?J => [NORTH, WEST],
    ?7 => [SOUTH, WEST],
    ?F => [SOUTH, EAST]
  }

  CAN_GO_MAP = {
    ?| => [:north, :south],
    ?- => [:east, :west],
    ?L => [:north, :west],
    ?J => [:north, :east],
    ?7 => [:south, :east],
    ?F => [:south, :west],
    ?S => [:north, :south, :east, :west]
  }

  def initialize(file)
    @matrix = File.readlines(FILE).map{|l| l.chomp.chars}
    @start_pos = find_start_cords
    @path = File.readlines(FILE).map{|l| l.chomp.chars}
    @been_to = {}
  end

  def mp(x:nil,y:nil,a:nil, ref: @matrix)    
    x, y = a unless a.nil?
    return nil if x.nil? || y.nil? || x < 0 || y < 0
    row = ref[y]
    return nil if row.nil?
    ref[y][x]
  end

  def get_pos_move(x:, y:, direction:)
    nx = x + direction.first
    ny = y + direction.last 
    {val: mp(a: [nx,ny]), x: nx, y: ny}
  end

  def get_around_location(x:,y:)
    north = get_pos_move(x:, y:, direction: NORTH)
    south = get_pos_move(x:, y:, direction: SOUTH)
    east  = get_pos_move(x:, y:, direction: EAST)
    west  = get_pos_move(x:, y:, direction: WEST)
    return {north:,south:,east:,west:}
  end

  def mark(c, step_counter)
    x = c[:x]
    y = c[:y]
    @path[y][x] = 'X'
    # if  @path[y][x].is_a?(Array)
    #  f = (@path.map {|x| x.map {|s| s.is_a?(Array) ? s : nil}.compact}.flatten.max+1) / 2
    #  raise "DONE: #{f}"
    # else
    #   @path[y][x] = []
    #   @path[y][x] << step_counter
    # end
  end

  def traversal(x: nil, y: nil, last: nil, step_counter: 0)
    # @path.each {|f| puts f.join}        
    
    # gets
    # puts  "="*100
    x = @start_pos[:x] if x.nil?
    y = @start_pos[:y] if y.nil?
    z = {x:,y:}
    mark(z, step_counter)      
    current_loc = mp(x:, y:)
    pp [x, y, current_loc, step_counter]
    surrounding = get_around_location(x:, y:)
    # pp [x,y,current_loc, surrounding, @matrix]
   
    unless last.nil?
      surrounding.delete_if {|direction, q| 
        (q[:x] == last[:x] && q[:y] == last[:y])
      }
    end 
    need_to_visit = surrounding.select {|direction,c|       
      TOUCH_MAPPINGS.keys.include?(c[:val]) && (! [?S,?.].include?(c[:val])) && CAN_GO_MAP[current_loc].include?(direction)
    }
    return @path if need_to_visit.keys.count == 0
    need_to_visit.each do |direction,c|
      traversal(x: c[:x], y: c[:y], last: {x:,y:}, step_counter: step_counter+1) 
    end
    return @path if current_loc == ?S 
  end

  private

  def find_start_cords
    s_row = @matrix.find {|y| y.any? {|x| x == ?S}}
    x = s_row.index(?S)
    y = @matrix.index(s_row)
    {x:, y:}
  end
end

@matrix = Matrix.new(FILE)
@matrix.traversal.each {|d| puts d.inspect}
all = []
@matrix.path.each do |row| 
  row.each do |v|
    all << v if v.is_a?(Array) && v[0] == v[1]
  end
end
pp all