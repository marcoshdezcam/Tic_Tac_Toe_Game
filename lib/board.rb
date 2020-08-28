require_relative '../lib/player.rb'

class Board
  attr_reader :game_board, :slots_taken

  def initialize
    @game_board = [
      [' ', ' ', ' '],
      [' ', ' ', ' '],
      [' ', ' ', ' ']
    ]
    @slots_taken = []
  end

  def show_board
    @game_board.each do |row|
      row.each { |col| print %(| #{col} | ) }
      puts %()
    end
  end

  def mark_board(player)
    @game_board[0][player.next_move - 1] = player.token if player.next_move.between?(1, 3)
    @game_board[1][player.next_move - 4] = player.token if player.next_move.between?(4, 6)
    @game_board[2][player.next_move - 7] = player.token if player.next_move.between?(7, 9)
    @slots_taken << player.next_move && player.moves << player.next_move
  end

  def marked?(player)
    if @slots_taken.include?(player.next_move)
      puts %(Slot taken. Select another.)
      true
    else
      false
    end
  end
end
