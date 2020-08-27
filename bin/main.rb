#!/usr/bin/env ruby
# rubocop: disable Style/Next
require_relative '../lib/game.rb'

puts %(First player; please type your name!)
player1 = Player.new(gets.chomp, 'X')
puts %(Second player; please type your name!)
player2 = Player.new(gets.chomp, 'O')
TicTacToe = Game.new(player1, player2)
puts %(Welcome #{TicTacToe.player1.name}! Your token is: #{TicTacToe.player1.token})
puts %(Welcome #{TicTacToe.player2.name}! Your token is: #{TicTacToe.player2.token})

loop do
  puts %(#{TicTacToe.player1.name}'s turn. Type a number between 1 and 9: )
  TicTacToe.player1.next_move = gets.chomp.to_i
  TicTacToe.mark_board(player1)
  TicTacToe.board_tic.show_board
  if TicTacToe.winner?(player1) || TicTacToe.draw?(player1)
    puts %(Congratulations #{player1.name}, you won!) if TicTacToe.winner?(player1)
    puts %(It's a draw game!) if TicTacToe.draw?(player1)
    break
  end

  puts %(#{TicTacToe.player2.name}'s turn. Type a number between 1 and 9: )
  TicTacToe.player2.next_move = gets.chomp.to_i
  TicTacToe.mark_board(player2)
  TicTacToe.board_tic.show_board
  if TicTacToe.winner?(player2) || TicTacToe.draw?(player2)
    puts %(Congratulations #{player2.name}, you won!) if TicTacToe.winner?(player2)
    puts %(It's a draw game!) if TicTacToe.draw?(player2)
    break
  end
end
# rubocop: enable Style/Next
