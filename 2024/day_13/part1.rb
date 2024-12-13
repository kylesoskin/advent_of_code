class Game
  attr_accessor :prize_location_x, :prize_location_y, 
                :current_x, :current_y, 
                :button_a_x, :button_b_x, 
                :button_a_y, :button_b_y

  def initialize(game_input)
    ba, bb, pr = game_input.map(&:chomp)
    @current_x, @current_y = 0,0
    @button_a_x, @button_a_y = ba.split(?:).last.split(", ").map {|x| x.split(?+).last.to_i}
    @button_b_x, @button_b_y = bb.split(?:).last.split(", ").map {|x| x.split(?+).last.to_i}
    @prize_location_x, @prize_location_y = pr.split(?:).last.split(?,).map {|d| d.split(?=).last.to_i}
  end

  def solve
    # math noodling
    # facts
    # @prize_location_x = (a_button_presses * (@button_a_x)) +  (b_button_presses * (@button_b_x))
    # @prize_location_y = (a_button_presses * (@button_a_y)) +  (b_button_presses * (@button_b_y))
    # 8400 = (a * 94) + (b * 22); 5400=(a *34) + (b * 67)
    # 94a + 22b = 8400; 34a + 67b = 5400
    # 67(94x + 22y)=67(8400); 22(34x + 67y) = 22(5400)
    # 67(94x + 22y)=67(8400); 22(34x + 67y) = 22(5400)
    # 67(94x + 22y)=562800; 22(34x + 67y) = 118800
    # 6298x + 1474y = 562800; 748x + 1474y = 118800
    # 6298x + 1474y = 562800; 748x + 1474y = 118800
    # 6298x = 562800 - 1474y; 748x = 118800 - 1474y
    # x = (562800 - 1474y)/6298
    # x = (118800 - 1474y)/748
    # (562800 - 1474y)/6298 = (118800 - 1474y)/748 # cross multiplyyyyy
    # (562800 - 1474y) * 748 = (118800 - 1474y) * 6298 < 
    # 420974400 - 1102552y = 748202400 - 9283252y # expand 
    # 420974400 = 748202400 - 9283252y + 1102552y
    # 420974400 = 748202400 - 9283252y + 1102552y
    # 327228000 = 8180700y
    # 327228000/8180700=y
    # y = 40
    # done, now in code
    # x1 = (@button_b_y(@prize_location_x) - @button_b_y(@button_b_x * y)) / @button_b_y (@button_a_x)
    # x2 = (@button_b_x(@prize_location_y) - @button_b_y(@button_b_x * y)) / @button_b_x (@button_a_y)
    
    # (67(8400) - (22*67)y) * (22*34) = (22(5400) - (22*67)y) * (67*(94))
    # (67(8400)(22*34)) =  - ((22*67)(67*94)y) + ((22*67)(22*34)y) 
    # (67(8400)(22*34)) - (22(5400)(67*94)) =  - ((22*67)(67*94)y) + ((22*67)(22*34)y) 

    # ((67(8400)(22*34)) - (22(5400)(67*94))) =  ((22*67)(22*34)-(22*67)(67*94))y
    # y = ((67(8400)(22*34)) - (22(5400)(67*94))) / ((22*67)(22*34)-(22*67)(67*94))
    y = ((@button_b_y * (@prize_location_x) * (@button_b_x * @button_a_y)) - (@button_b_x * (@prize_location_y)*(@button_b_y*@button_a_x))) / ((@button_b_x*@button_b_y)*(@button_b_x*@button_a_y)-(@button_b_x*@button_b_y)*(@button_b_y*@button_a_x))
    # @prize_location_y=(x * @button_a_y) + (y * @button_b_y)
    x = (@prize_location_y - (y * @button_b_y)) / @button_a_y
    end_x = (@button_a_x * x) + (@button_b_x * y)
    end_y = (@button_a_y * x) + (@button_b_y * y)
    [x*3 + y, [end_x, end_y] == [@prize_location_x, @prize_location_y]]
    end

end

games = File.read('input.txt').lines.each_slice(4).map {|g| [t=Game.new(g), t.solve]}
pp games.select {|d| d.last.last == true}.sum {|d| d.last.first}


