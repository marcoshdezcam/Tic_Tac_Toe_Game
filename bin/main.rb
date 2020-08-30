#!/usr/bin/env ruby
require_relative '../lib/game.rb'

def create_players
  new_players = Array.new(2, Player)
  tokens = %w[X O]
  2.times do |i|
    puts %(Player #{i + 1}, please type your name!)
    begin
      new_name = gets.chomp
      raise RuntimeError if Player.validate_name(new_name).nil?
    rescue RuntimeError
      puts %(Invalid name! Please, try again.)
      retry
    else
      new_players[i] = Player.new(new_name, tokens[i])
    end
  end
  new_players
end

def welcome(new_players)
  puts %(Welcome #{new_players[0].name}! Your token is: #{new_players[0].token})
  puts %(Welcome #{new_players[1].name}! Your token is: #{new_players[1].token})
  new_players
end

def ask_move(player, board)
  puts %(#{player.name}'s turn. Type a number between 1 and 9. )
  begin
    new_move = gets.chomp.to_i
    raise RuntimeError unless new_move.between?(1, 9)
  rescue RuntimeError
    puts %(Wrong number, please use a number between 1 and 9.)
    retry
  else
    player.next_move = new_move
    if board.marked?(player)
      puts %(Slot taken, choose a different number)
      ask_move(player)
    end
  end
end

def play(game)
  2.times do |i|
    ask_move(game.players[i], game.board)
    game.move_player(game.players[i])
    if game.board.slots_taken.size >= 5 && game.winner?(game.players[i])
      puts %(Congratulations! #{game.players[i].name} won!)
      break
    end
    if game.board.slots_taken.size.eql?(9) && game.draw?(game.players[i])
      puts %(It's a draw!)
      break
    end
  end
end

TicTacToe = Game.new(welcome(create_players))

loop do
  play(TicTacToe)
  break if TicTacToe.winner
  break if TicTacToe.draw
end
