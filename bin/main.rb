#!/usr/bin/env ruby
require_relative '../lib/game.rb'

# LOOP Players
player = Array.new(2)
2.times do |i|
  puts %(Player #{i + 1}, please type your name!)
  begin
    new_name = gets.chomp
    raise RuntimeError if Player.validate_name(new_name).nil?
  rescue RuntimeError
    puts %(Invalid input! Please, try again.)
    retry
  else
    puts %(Enter a character as your token.)
    new_token = Player.create_token(gets.chomp)
  ensure
    player[i] = Player.new(new_name, new_token)
  end
end
