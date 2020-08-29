require_relative '../lib/board.rb'
class Game
  attr_reader :board, :players, :winner, :draw

  def initialize(new_players)
    @board = Board.new
    @players = new_players
    @winner = nil
    @draw = false
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
      ask_move(new_player) if @board.marked?(new_player)
    end
  end

  def move_players
    2.times do |i|
      ask_move(@players[i])
      @board.mark_board(@players[i])
      @board.show_board
      break if @board.slots_taken.size >= 5 && winner?(@players[i])
      break if @board.slots_taken.size.eql?(9) && draw?(@players[i])
    end
  end

  def play
    loop do
      move_players
      break unless @winner.nil?
      break if @draw
    end
  end

  def winner?(player)
    if horizontal_win?(player) || vertical_win?(player) || diagonal_win?(player)
      @winner = player
      puts %(Congratulations #{player.name} you won!)
      true
    else
      false
    end
  end

  def horizontal_win?(player)
    @board.game_board.each { |row| return true if row.all?(player.token) }
    false
  end

  def vertical_win?(player)
    if [@board.game_board[0][0], @board.game_board[1][0], @board.game_board[2][0]].all?(player.token) ||
       [@board.game_board[0][1], @board.game_board[1][1], @board.game_board[2][1]].all?(player.token) ||
       [@board.game_board[0][2], @board.game_board[1][2], @board.game_board[2][2]].all?(player.token)
      true
    else
      false
    end
  end

  def diagonal_win?(player)
    if [@board.game_board[0][0], @board.game_board[1][1], @board.game_board[2][2]].all?(player.token) ||
       [@board.game_board[0][2], @board.game_board[1][1], @board.game_board[2][0]].all?(player.token)
      true
    else
      false
    end
  end

  def draw?(player)
    @draw = true unless winner?(player)
  end
end
