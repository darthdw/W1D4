require_relative "board"

class Game

  def initialize
    @board = Board.new
  end

  def run
    until over?
      @board.render_board
      puts "Do you want to 'reveal' a tile or 'flag' a tile?"
      input = gets.chomp
      parse_option(input)
    end
  end

  def flagging
    print("You are flag/unflagging a tile. ")
    pos = pick_tile
    @board[pos].toggle_flag
  end

  def revealing
    print("You are revealing a tile. ")
    pos = pick_tile
    @board[pos].reveal_tile
  end

  def pick_tile
    puts("Please input a tile coordinate: ")
    input = gets.chomp
    parse_input(input)
  end

  def parse_option(string)
    if string.include?("flag")
       flagging
    else
       revealing
    end
  end

  def parse_input(words)
    words.split(",").map {|num| num.to_i}
  end

  def over?
  end

  def flag_tile

  end

  def lose!
    reveal_all
    puts("YOU LOST, NOOB!")
  end

  def reveal_all
    arr = (0...@board.grid.size).to_a
    arr = arr.permutation(2).to_a
    arr.each do |ele|
      @board[ele].reveal_tile
    end
  end

end


game = Game.new
game.run
