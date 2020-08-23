#!/usr/bin/env ruby
class Game
  attr_accessor :tic_tac_toe, :player1, :player2

  def initialize
    @tic_tac_toe = Board.new
    puts %(First player; please type your name!)
    @player1 = Player.new(gets.chomp, 'X')
    puts %(Second player; please type your name!)
    @player2 = Player.new(gets.chomp, 'O')
  end

  def welcome
    puts %(Welcome on board #{@player1.name} and #{@player2.name}, let the Tic-Tac-Toe game begins!)
    puts %(Player 1: #{@player1.name} has token: #{@player1.token})
    puts %(Player 2: #{@player2.name} has token: #{@player2.token})
  end

  def play
    welcome
    @tic_tac_toe.ask_player_move(@player1)
    @tic_tac_toe.mark_player_move(@player1)
    @tic_tac_toe.show_board
    @tic_tac_toe.ask_player_move(@player2)
    @tic_tac_toe.mark_player_move(@player2)
    @tic_tac_toe.show_board
  end
end

class Board
  attr_reader :winning_coords
  attr_accessor :game_board

  def initialize
    @game_board = [
      ['-', '-', '-'],
      ['-', '-', '-'],
      ['-', '-', '-']
    ]
  end

  def show_board
    @game_board.each { |itr| puts %( | #{itr[0]} | | #{itr[1]} | | #{itr[2]} |) }
  end

  def ask_player_move(player)
    puts %(#{player.name}'s turn. Use a number from 1 to 9: )
    player.next_move = gets.chomp.to_i
    until player.next_move.between?(1, 9)
      puts %(Invalid move. Only use numbres from 1 to 9. Try again: )
      player.next_move = gets.chomp.to_i
    end
  end

  def mark_player_move(player)
    puts %(#{player.name} move is #{player.next_move})
  end

  def check_winner
    true
  end

  def check_draw
    true
  end
end

class Player
  attr_accessor :name, :next_move, :moves, :token

  def initialize(name, token)
    @name = name
    @next_move = []
    @moves = [[]]
    @token = token
  end

  def move
    move_coords = gets.chomp.to_i
    puts move_coords
  end
end

TicTacToe = Game.new
TicTacToe.play
