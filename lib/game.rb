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

  def Game.validate_players
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

  def play
    turn_number = 0
    loop do
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
        ensure
          turn_number += 1
        end
      end
    end
  end

  def mark_board(player)
    return if @board_tic.marked?(player)

    @board_tic.game_board[0][player.next_move - 1] = player.token if player.next_move.between?(1, 3)
    @board_tic.game_board[1][player.next_move - 4] = player.token if player.next_move.between?(4, 6)
    @board_tic.game_board[2][player.next_move - 7] = player.token if player.next_move.between?(7, 9)
    @board_tic.slots_taken << player.next_move && player.moves << player.next_move
  end

  def winner?(player)
    winning_moves.any?(player.moves)
  end

  def draw?(player)
    @board_tic.slots_taken.size == 9 && !winner?(player)
  end
end
