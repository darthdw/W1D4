class Tile

  attr_accessor :bomb, :neighbor_danger

  def initialize()
    @bomb = false
    @flagged = false
    @revealed = false
    @neighbor_danger = 0
  end

  def plant_bomb
    @bomb = true
  end


  def reveal_tile
    @revealed = true
  end

  def toggle_flag
    if @flagged
      @flagged = false
    else
      @flagged = true
    end
  end

  def show_element
    # if @revealed && @neighbor_danger == 0
    #   "|   |"
    # els
    if @revealed && @bomb
      "| B |"
      game.lose!
    elsif @revealed
      @neighbor_danger.to_s
    elsif @flagged
      "| * |"
    else
      "| . |"
    end
  end



end
