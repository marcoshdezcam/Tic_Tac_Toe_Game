class Player
  attr_accesor :next_move
  attr_reader :name, :token

  def initialize(name, token)
    @name = name
    @next_move = []
    @moves = []
    @token = token
  end
end
