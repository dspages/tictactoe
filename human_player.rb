require_relative "player"

class HumanPlayer < Player

  VALID = ["0", "1", "2"]

  def get_move
    puts "Choose a move format is eg 10 for 1st row, 0th column"
    valid = true
    move = gets.chomp.split("")
    valid = false if move.length != 2
    if valid
      move.each do |char|
        valid = false unless VALID.include?(char)
      end
      move.map!(&:to_i)
      valid = false unless @board.valid_moves.include?(move)
    end
    if valid
      move
    else
      puts "Invalid move! Try again"
      get_move
    end
  end

  def set_name
    puts "Enter your name"
    @name = gets.chomp
  end

end
