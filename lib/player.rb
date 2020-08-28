class Player
  attr_accessor :next_move, :moves
  attr_reader :name, :token

  def initialize(name, token)
    @name = name
    @next_move = []
    @moves = []
    @token = token
  end

  def self.validate_name(new_name)
    new_name.to_s.strip.empty? ? nil : new_name
  end
end
