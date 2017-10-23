
require_relative "board"
require_relative "easy_computer_player"
require_relative "hard_computer_player"
require_relative "human_player"

class Game

  def move
    @board.render
    sleep 0.1
    puts "#{@current_player.name}'s move"
    move = @current_player.get_move
    @board[move] = @current_player.symbol
    @current_player = @current_player.opponent
  end

  def game_loop
    move until @board.over?
  end

  def post_game_analysis
    @board.render
    if @board.won?(@p1.symbol)
      puts "#{@p1.name} wins!"
    elsif @board.won?(@p2.symbol)
      puts "#{@p2.name} wins!"
    else
      puts "Tie."
    end
    sleep 2
    puts "Play again? y for yes, anything else for no"
    response = gets.chomp
    play if response.downcase == "y"
  end

  def play
    @board = Board.new
    puts "Would you like a hard difficulty? y for yes, anything else for no"
    difficulty = gets.chomp
    if difficulty.downcase == "y"
      @p1 = HardComputerPlayer.new(:X, @board)
      @p2 = HumanPlayer.new(:O, @board)
    else
      @p2 = EasyComputerPlayer.new(:O, @board)
      @p1 = HumanPlayer.new(:X, @board)
    end
    @p1.set_name
    @p2.set_name
    @p1.opponent = @p2
    @p2.opponent = @p1
    @current_player = @p1
    game_loop
    post_game_analysis
  end

end

game = Game.new
game.play
