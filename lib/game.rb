require_relative '../lib/board.rb'
class Game
  attr_reader :board, :players, :turn, :winner

  def initialize(new_players)
    @board = Board.new
    @players = new_players
    @turn = 0
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

  def ask_move(new_player)
    puts %(#{new_player.name}'s turn. Type a number between 1 and 9. )
    begin
      new_move = gets.chomp.to_i
      raise RuntimeError unless new_move.between?(1, 9)
    rescue RuntimeError
      puts %(Wrong number, please use a number between 1 and 9.)
      retry
    else
      new_player.next_move = new_move
      if @board.marked?(new_player)
        ask_move(new_player)
      else
        @turn += 1
      end
    end
  end

  def move_players
    2.times do |i|
      ask_move(@players[i])
      @board.mark_board(@players[i])
      @board.show_board
      if @turn >= 5 && winner?(@players[i]) || @turn.eql?(9) && draw?(@players[i])
        @winner = @players[i]
        break
      end
    end
  end

  def play
    loop do
      move_players
      break unless @winner.nil?
    end
  end

  def winner?(player)
    if [@board.game_board[0][0], @board.game_board[0][1], @board.game_board[0][2]].all?(player.token) ||
       [@board.game_board[1][0], @board.game_board[1][1], @board.game_board[1][2]].all?(player.token) ||
       [@board.game_board[2][0], @board.game_board[2][1], @board.game_board[2][2]].all?(player.token) ||
       [@board.game_board[0][0], @board.game_board[1][0], @board.game_board[2][0]].all?(player.token) ||
       [@board.game_board[0][1], @board.game_board[1][1], @board.game_board[2][1]].all?(player.token) ||
       [@board.game_board[0][2], @board.game_board[1][2], @board.game_board[2][2]].all?(player.token) ||
       [@board.game_board[0][0], @board.game_board[1][1], @board.game_board[2][2]].all?(player.token) ||
       [@board.game_board[0][2], @board.game_board[1][1], @board.game_board[2][0]].all?(player.token)
      puts %(Congratulations #{player.name}! You won!)
      true
    else
      false
    end
  end

  def draw?(player)
    @board.slots_taken.size == 9 && !winner?(player)
  end
end
