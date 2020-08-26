#!/usr/bin/env ruby
require_relative '../lib/game.rb'

puts %(First player; please type your name!)
player1 = gets.chomp
puts %(Second player; please type your name!)
player2 = gets.chomp
TicTacToe = Game.new(player1, player2)
puts %(Welcome #{TicTacToe.player1.name}! Your token is: #{TicTacToe.player1.token})
puts %(Welcome #{TicTacToe.player2.name}! Your token is: #{TicTacToe.player2.token})

# Ask for moves

# Mark moves

# Show board

# Draw?

# Winner?
