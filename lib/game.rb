require_relative '../lib/board.rb'
class Game
  attr_reader :board_tic, :players, :winning_moves

  def initialize(new_players)
    @board_tic = Board.new
    @players = new_players
    @winning_moves = [
      [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
      [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]
    ]
  end

  def self.validate_players
    new_players = Array.new(2)
    tokens = %w[X O]
    2.times do |i|
      puts %(Player #{i + 1}, please type your name!)
      begin
        new_name = gets.chomp
        raise RuntimeError if Player.validate_name(new_name).nil?
      rescue RuntimeError
        puts %(Invalid input! Please, try again.)
        retry
      else
        new_players[i] = Player.new(new_name, tokens[i])
      end
    end
    new_players
  end

  def welcome
    puts %(Welcome #{@players[0].name}! Your token is: #{@players[0].token})
    puts %(Welcome #{@players[1].name}! Your token is: #{@players[1].token})
  end

  def ask_moves
    2.times do |i|
      puts %(#{@players[i].name}'s turn. Type a number between 1 and 9. )
      begin
        new_move = gets.chomp.to_i
        raise RuntimeError unless new_move.between?(1, 9)
      rescue RuntimeError
        puts %(Wrong number, please use a number between 1 and 9.)
        retry
      else
        @players[i].next_move = new_move
        redo if @board_tic.marked?(@players[i])
        @board_tic.mark_board(@players[i])
        @board_tic.show_board
        winner?
      end
    end
  end

  def play
    loop do
      ask_moves
      # winner? until turn_number.eql?(4)
      # draw? until turn_number.eql?(8)
    end
  end

  def winner?
    2.times do |i|
    if [@board_tic.game_board[0][0], @board_tic.game_board[0][1], @board_tic.game_board[0][2]].all?(players[i].token) ||
       [@board_tic.game_board[1][0], @board_tic.game_board[1][1], @board_tic.game_board[1][2]].all?(players[i].token) ||
       [@board_tic.game_board[2][0], @board_tic.game_board[2][1], @board_tic.game_board[2][2]].all?(players[i].token) ||
       [@board_tic.game_board[0][0], @board_tic.game_board[1][0], @board_tic.game_board[2][0]].all?(players[i].token) ||
       [@board_tic.game_board[0][1], @board_tic.game_board[1][1], @board_tic.game_board[2][1]].all?(players[i].token) ||
       [@board_tic.game_board[0][2], @board_tic.game_board[1][2], @board_tic.game_board[2][2]].all?(players[i].token) ||
       [@board_tic.game_board[0][0], @board_tic.game_board[1][1], @board_tic.game_board[2][2]].all?(players[i].token) ||
       [@board_tic.game_board[0][2], @board_tic.game_board[1][1], @board_tic.game_board[2][0]].all?(players[i].token)
      true
    end
    winning_moves.any?(players[i].moves)
  end
  end

  def draw?(player)
    @board_tic.slots_taken.size == 9 && !winner?(player)
  end
end
