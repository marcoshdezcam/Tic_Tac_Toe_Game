require_relative '../lib/board.rb'

class Game
  attr_reader :winning_moves
  attr_accessor :tic_tac_toe, :player1, :player2

  def initialize(player1_name, player2_name)
    @winning_moves = [
      [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
      [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]
    ]
    @tic_tac_toe = Board.new
    @player1 = Player.new(player1_name, 'X')
    @player2 = Player.new(player2_name, 'O')
  end

  def play
    loop do
      @tic_tac_toe.mark_move(@player1)
      @tic_tac_toe.show_board
      @tic_tac_toe.winner?(@player1)
      @tic_tac_toe.draw?(@player1)
      @tic_tac_toe.ask_move(@player2)
      @tic_tac_toe.mark_move(@player2)
      @tic_tac_toe.show_board
      @tic_tac_toe.winner?(@player2)
      @tic_tac_toe.draw?(@player2)
    end
  end
end
