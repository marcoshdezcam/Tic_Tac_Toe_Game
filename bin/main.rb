#!/usr/bin/env ruby

  def player_info
    puts "First player; please type your name!"
    name1 = gets.chomp
    puts "Second player; please type your name!"
    name2 = gets.chomp
    player_1 = "X"
    player_2 = "O"
    puts "#{name1} has '#{player_1}' symbol"
    puts "#{name2} has '#{player_2}' symbol"
    puts "Welcome on board #{name1} and #{name2}, let the Tic-Tac-Toe game begins!"
    board_positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    counter = 0
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

 p player_info
 p show_board



