class Match
  attr_reader :players

  def initialize(player1, player2)
    @players = { one: player1, two: player2 }
  end

  def add_point(player)
    @players[player].add_point
  end

  def scores
    { one: @players[:one].attributes,
      two: @players[:two].attributes }
  end
end
