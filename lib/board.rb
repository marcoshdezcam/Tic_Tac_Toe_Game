require_relative '../lib/player.rb'

class Board
  attr_accessor :game_board, :slots_taken

  def initialize
    @game_board = [
      [' ', ' ', ' '],
      [' ', ' ', ' '],
      [' ', ' ', ' ']
    ]
    @slots_taken = []
  end

  def show_board
    @game_board.each { |itr| puts %( | #{itr[0]} | | #{itr[1]} | | #{itr[2]} |) }
  end

  def marked?(player)
    @slots_taken.include?(player.next_move)
  end
end
