require_relative '../lib/board.rb'

class Game
  attr_reader :winning_moves
  attr_accessor :board_tic, :player1, :player2, :winner

  def initialize(player1, player2)
    @winning_moves = [
      [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
      [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]
    ]
    @board_tic = Board.new
    @player1 = player1
    @player2 = player2
  end

  def mark_board(player)
    return if @board_tic.marked?(player)

    @board_tic.game_board[0][player.next_move - 1] = player.token if player.next_move.between?(1, 3)
    @board_tic.game_board[1][player.next_move - 4] = player.token if player.next_move.between?(4, 6)
    @board_tic.game_board[2][player.next_move - 7] = player.token if player.next_move.between?(7, 9)
    @board_tic.slots_taken << player.next_move
  end

  def winner?(player)
    if [@board_tic.game_board[0][0], @board_tic.game_board[0][1], @board_tic.game_board[0][2]].all?(player.token) ||
      [@board_tic.game_board[1][0], @board_tic.game_board[1][1], @board_tic.game_board[1][2]].all?(player.token) ||
      [@board_tic.game_board[2][0], @board_tic.game_board[2][1], @board_tic.game_board[2][2]].all?(player.token) ||
      [@board_tic.game_board[0][0], @board_tic.game_board[1][0], @board_tic.game_board[2][0]].all?(player.token) ||
      [@board_tic.game_board[0][1], @board_tic.game_board[1][1], @board_tic.game_board[2][1]].all?(player.token) ||
      [@board_tic.game_board[0][2], @board_tic.game_board[1][2], @board_tic.game_board[2][2]].all?(player.token) ||
      [@board_tic.game_board[0][0], @board_tic.game_board[1][1], @board_tic.game_board[2][2]].all?(player.token) ||
      [@board_tic.game_board[0][2], @board_tic.game_board[1][1], @board_tic.game_board[2][0]].all?(player.token)
      true
    end
  end

  def draw?(player)
    @board_tic.slots_taken.size == 9 && !winner?(player)
  end
end
