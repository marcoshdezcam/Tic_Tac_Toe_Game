#!/usr/bin/env ruby
require_relative '../lib/game.rb'

TicTacToe = Game.new(Game.validate_players)
p TicTacToe
