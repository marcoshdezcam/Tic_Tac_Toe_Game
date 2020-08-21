#!/usr/bin/env ruby
class Game
  attr_reader :winning_coords
  attr_accessor :player1, :player2

  def initialize
    @winning_coords = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    puts 'First player; please type your name!'
    name1 = gets.chomp
    player1 = Player.new(name1, 'X')
    puts 'Second player; please type your name!'
    name2 = gets.chomp
    player2 = Player.new(name2, 'O')

    puts "Welcome on board #{player1.name} and #{player2.name}, let the Tic-Tac-Toe game begins!"
    puts %(Player 1: #{player1.name} has token: #{player1.token})
    puts %(Player 2: #{player2.name} has token: #{player2.token})
    new_board = Board.new
    new_board.show_board
  end

  def play
    while Board.check_winner == false && Board.check_draw == false
      new_board.mark_move(5, player1.token)
      new_board.show_board
    end
  end
end

class Board
  attr_accessor :game_board

  def initialize
    @game_board = Array.new(9, '-')
  end

  def show_board
    puts "Show Game Board!"
    puts "................."
    puts "| #{game_board[0]} | | #{game_board[1]} | | #{game_board[2]} |"
    puts "................."
    puts "| #{game_board[3]} | | #{game_board[4]} | | #{game_board[5]} |"
    puts "................."
    puts "| #{game_board[6]} | | #{game_board[7]} | | #{game_board[8]} |"
  end

  def mark_move(coords, token)
    game_board[coords] = token
  end

  def check_winner
    false
  end

  def check_draw
    false
  end
end

class Player
  attr_accessor :name, :moves, :token

  def initialize(name, token)
    @name = name
    @token = token
  end

  def move
    puts %(Use numbers from 1 to 9.)
    puts %(#{name} next move is: )
    move_coords = gets.chomp.to_i
    puts move_coords
  end
end

TicTacToe = Game.new
TicTacToe.play
