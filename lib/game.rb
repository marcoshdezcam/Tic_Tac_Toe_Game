require_relative '../lib/board.rb'
class Game
  attr_reader :board, :players, :winner, :draw

  def initialize(new_players)
    @board = Board.new
    @players = new_players
    @winner = false
    @draw = false
  end

  def move_player(player)
    @board.mark_board(player)
    @board.show_board
  end

  def winner?(player)
    if horizontal_win?(player) || vertical_win?(player) || diagonal_win?(player)
      @winner = true
      true
    else
      false
    end
  end

  def horizontal_win?(player)
    @board.game_board.each { |row| return true if row.all?(player.token) }
    false
  end

  def vertical_win?(player)
    if [@board.game_board[0][0], @board.game_board[1][0], @board.game_board[2][0]].all?(player.token) ||
       [@board.game_board[0][1], @board.game_board[1][1], @board.game_board[2][1]].all?(player.token) ||
       [@board.game_board[0][2], @board.game_board[1][2], @board.game_board[2][2]].all?(player.token)
      true
    else
      false
    end
  end

  def diagonal_win?(player)
    if [@board.game_board[0][0], @board.game_board[1][1], @board.game_board[2][2]].all?(player.token) ||
       [@board.game_board[0][2], @board.game_board[1][1], @board.game_board[2][0]].all?(player.token)
      true
    else
      false
    end
  end

  def draw?(player)
    @draw = true unless winner?(player)
  end
end
