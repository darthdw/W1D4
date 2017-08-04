require_relative "tile"
require "byebug"

class Board

  def self.new_game
    this_game = Board.new
    this_game.seed_bombs
  end

  def initialize
    @grid = Array.new(9) {Array.new(9) {Tile.new}}
  end

  def seed_bombs
    bombs = 81
    # bombs = (@grid.size / 2) ** 2
    arr = random_spots.shuffle
    until bombs.zero?
      temp = arr.shift
      @grid[temp[0]][temp[1]].plant_bomb
      bombs -= 1
    end
    until arr.empty?
      target = arr[0]
      neighbors = count_neightbors(target)
      temp = arr.shift
      @grid[temp[0]][temp[1]].neighbor_danger = count_neightbors(temp)
    end
  end

  def count_neightbors(pos)
    x = pos[0]
    y = pos[1]
    count = 0

      if x > 0
        count += 1 if @grid[x - 1][y].bomb
        count += 1 if @grid[x + 1][y].bomb if x < @grid.size - 1
      end

      if y > 0
        count += 1 if @grid[x][y - 1].bomb
        count += 1 if @grid[x][y + 1].bomb if y < @grid.size - 1
      end

      if y > 0 && x > 0
        count += 1 if @grid[x + 1][y + 1].bomb if y < @grid.size - 1 && x < @grid.size - 1
        count += 1 if @grid[x - 1][y + 1].bomb if y < @grid.size - 1
        count += 1 if @grid[x + 1][y - 1].bomb if x < @grid.size - 1
        count += 1 if @grid[x - 1][y - 1].bomb if y < @grid.size - 1 && x < @grid.size - 1
      end

    count
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def random_spots #spots for bombs
    arr = (0...@grid.size).to_a
    arr = arr.permutation(2).to_a
  end

  def render_board
    (0...@grid.size).each do |idx0|
      (0...@grid.size).each do |idx1|
        print @grid[idx0][idx1].show_element
      end
      puts
    end
  end

end
