class Board

  def get_wins
    wins = []
    3.times do |i|
      wins << [[i, 0], [i, 1], [i, 2]]
      wins << [[0, i], [1, i], [2, i]]
    end
    wins << [[0, 0], [1, 1], [2, 2]]
    wins << [[0, 2], [1, 1], [2, 0]]
    wins
  end

  def initialize(grid = nil, wins = nil)
    @wins = wins || get_wins
    @grid = Array.new
    if grid.nil?
      3.times do
        @grid << Array.new(3)
      end
    else
      grid.each do |row|
        @grid << row.dup
      end
    end
  end

  def dup
    Board.new(@grid, @wins)
  end

  def render
    @grid.each do |row|
      parsed = []
      row.each do |tile|
        if tile.nil?
          parsed << "-"
        else
          parsed << tile
        end
      end
      puts parsed.join("|")
    end
  end

  def valid_moves
    valid = []
    3.times do |i|
      3.times do |j|
        move = [i, j]
        valid << move if self[move].nil?
      end
    end
    valid
  end

  def won?(symbol)
    @wins.each do |win|
      return true if win.all? do |coord|
        self[coord] == symbol
      end
    end
    false
  end

  def over?
    return true if won?(:X)
    return true if won?(:O)
    full?
  end

  def full?
    @grid.each do |row|
      row.each do |tile|
        return false if tile.nil?
      end
    end
    true
  end

  def [](loc)
    @grid[loc[0]][loc[1]]
  end

  def []=(loc, symbol)
    @grid[loc[0]][loc[1]] = symbol
  end

end

# board = Board.new
# board.render
# board[[0, 1]] = :X
# board.render
