require_relative "player"
require 'byebug'

class HardComputerPlayer < Player

  def score(board, perspective, opponent)
    return -1 if board.won?(opponent)
    return 1 if board.won?(perspective)
    return 0 if board.full?
    nil
  end

  def get_value(move, board, perspective)
    opponent = perspective == :X ? :O : :X
    score = score(board, perspective, opponent)
    return score unless score.nil?
    next_board = board.dup
    next_board[move] = perspective
    score = score(board, perspective, opponent)
    return score unless score.nil?
    -find_reasonable_moves(next_board, opponent)[:value]
  end

  def find_reasonable_moves(board, perspective)
    winning = []
    normal = []
    losing = []
    moves = board.valid_moves
    moves.each do |move|
      value = get_value(move, board, perspective)
      winning << move if value == 1
      normal << move if value == 0
      losing << move if value == -1
    end
    return { value: 1, moves: winning } unless winning.empty?
    return { value: 0, moves: normal } unless normal.empty?
    return { value: -1, moves: losing } unless losing.empty?
    { value: 0, moves: [] }
  end

  def get_move
    return [1, 1] if @board.valid_moves.include?([1, 1]) ##First move should be in center
    moves = find_reasonable_moves(@board, @symbol)
    raise "INVALID MOVE ERROR" if moves.empty?
    #p moves
    moves[:moves].sample
  end

  def set_name
    @name = "KILLBOT 9001"
  end

end
