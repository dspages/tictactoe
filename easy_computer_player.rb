require_relative "player"

class EasyComputerPlayer < Player

  def get_move
    moves = @board.valid_moves
    raise "INVALID MOVE ERROR" if moves.empty?
    p moves
    moves.sample
  end

  def set_name
    @name = "Bozo"
  end

end
