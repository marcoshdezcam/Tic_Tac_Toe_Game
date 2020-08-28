require_relative '../lib/board.rb'
class Game
  attr_reader :board_tic, :player1, :player2, :winning_moves

  def initialize(players)
    @board_tic = Board.new
    @player1 = players[0]
    @player2 = players[1]
    @winning_moves = [
      [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
      [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]
    ]
  end

  def self.validate_players
    players = Array.new(2)
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
        players[i] = Player.new(new_name, tokens[i])
      end
    end
    players
  end

  def welcome
    puts %(Welcome #{@player1.name}! Your token is: #{@player1.token})
    puts %(Welcome #{@player2.name}! Your token is: #{@player2.token})
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
