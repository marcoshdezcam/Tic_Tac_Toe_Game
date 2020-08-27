class Player
  attr_reader :name, :next_move, :moves, :token

  def initialize(name, token)
    @name = name
    @next_move = []
    @moves = []
    @token = token
  end
end
