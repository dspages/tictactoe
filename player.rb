class Player

  attr_reader :symbol, :name, :board
  attr_accessor :opponent
  def initialize(symbol, board)
    @symbol = symbol
    @board = board
  end

end
