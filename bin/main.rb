#!/usr/bin/env ruby
class Game < Player
  attr_reader :winning_coords
  attr_accessor :player1, :player2

  def initialize
    @winning_coords = [[1, 2, 3][4, 5, 6][7, 8, 9][1, 4, 7][2, 5, 8][3, 6, 9][1, 5, 9][7, 5, 3]]
    puts 'First player; please type your name!'
    name1 = gets.chomp
    player1 = Player.new(name1, 'O')
    puts 'Second player; please type your name!'
    name2 = gets.chomp
    player2 = Player.new(name2, 'X')

    puts "Welcome on board #{player1.name} and #{player2.name}, let the Tic-Tac-Toe game begins!"
    puts %(Player 1: #{player1.name} has token: #{player1.token})
    puts %(Player 2: #{player2.name} has token: #{player2.token})
    # board_positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    # counter = 0
  end
end

class Board

  attr_accessor :game_board

  def initialize
    @game_board = Array.new(9)
  end

  def show_board
    board_positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    puts "Show Game Board!"
    puts "................."
    puts "| #{board_positions[0]} | | #{board_positions[1]} | | #{board_positions[2]} |"
    puts "................."
    puts "| #{board_positions[3]} | | #{board_positions[4]} | | #{board_positions[5]} |"
    puts "................."
    puts "| #{board_positions[6]} | | #{board_positions[7]} | | #{board_positions[8]} |"
  end
end

class Player
  attr_accessor :name, :moves, :token

  def initialize(name, token)
    @name = name
    @token = token
  end
end

TicTacToe = Game.new
