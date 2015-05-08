class Match
  attr_reader :players

  def initialize(player1, player2)
    @players = { one: player1, two: player2 }
  end

  def add_point(player)
    @players[player].add_point
    if @players[:one].has_beaten(@players[:two])
      @players[:one].reset_score
      @players[:two].reset_score
      @players[:one].add_game
    elsif @players[:two].has_beaten(@players[:one])
      @players[:one].reset_score
      @players[:two].reset_score
      @players[:two].add_game
    end
  end

  def scores
    { one: @players[:one].attributes,
      two: @players[:two].attributes }
  end
end
