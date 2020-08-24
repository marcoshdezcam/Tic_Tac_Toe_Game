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
    until @tic_tac_toe.winner?
      @tic_tac_toe.ask_move(@player1)
      @tic_tac_toe.mark_move(@player1)
      @tic_tac_toe.show_board
      @tic_tac_toe.ask_move(@player2)
      @tic_tac_toe.mark_move(@player2)
      @tic_tac_toe.show_board
    end
  end
end

class Board
  attr_reader :winning_coords
  attr_accessor :game_board

  def initialize
    @game_board = [
      [' ', ' ', ' '],
      [' ', ' ', ' '],
      [' ', ' ', ' ']
    ]
  end

  def show_board
    @game_board.each { |itr| puts %( | #{itr[0]} | | #{itr[1]} | | #{itr[2]} |) }
  end

  def ask_move(player)
    puts %(#{player.name}'s turn. Use a number between 1 and 9: )
    player.next_move = gets.chomp.to_i
    unless marked?(player)
      puts %(Slot already taken! Choose a different number.)
      player.next_move = gets.chomp.to_i
    end
    until player.next_move.between?(1, 9)
      puts %(Invalid move. Only use numbres bwteen 1 and 9. Try again: )
      player.next_move = gets.chomp.to_i
    end
  end

  def mark_move(player)
    @game_board[0][player.next_move - 1] = player.token if player.next_move.between?(1, 3)
    @game_board[1][player.next_move - 4] = player.token if player.next_move.between?(4, 6)
    @game_board[2][player.next_move - 7] = player.token if player.next_move.between?(7, 9)
  end

  def winner?
    false
  end

  def marked?
    false
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

  def move(new_position); end
end

TicTacToe = Game.new
TicTacToe.play
