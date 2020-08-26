require_relative '../lib/player.rb'

class Board
  attr_accessor :game_board, :slots_taken

  def initialize
    @slots_taken = []
    @game_board = [
      [' ', ' ', ' '],
      [' ', ' ', ' '],
      [' ', ' ', ' ']
    ]
  end

  def show_board
    current_board = []
    @game_board.each do |row|
      current_board << row[0]
      current_board << row[1]
      current_board << row[2]
    end
    current_board
  end

  def mark_move(player)
    return if marked?

    @game_board[0][player.next_move - 1] = player.token if player.next_move.between?(1, 3)
    @game_board[1][player.next_move - 4] = player.token if player.next_move.between?(4, 6)
    @game_board[2][player.next_move - 7] = player.token if player.next_move.between?(7, 9)
  end

  def winner?(player)
    winning_moves.any?(player.moves)
  end

  def draw?(player)
    @slots_taken.size == 9 && !winner?(player)
  end

  def marked?(player)
    @slots_taken.include?(player.next_move)
  end
end
