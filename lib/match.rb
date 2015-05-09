class Match
  def initialize
    @one, @two = Player.new('Player One'), Player.new('Player Two')
  end

  def add_point(colour)
    players[colour].add_point
    if @one.has_beaten(@two)
      reset_scores
      @one.add_game
    elsif @two.has_beaten(@one)
      reset_scores
      @two.add_game
    end
  end

  def reset_scores
    @one.reset_score
    @two.reset_score
  end

  def reset_games
    @one.reset_games
    @two.reset_games
  end

  def total_games
    @one.games + @two.games
  end

  def players
    if total_games.even?
      { red: @one, blue: @two }
    else
      { red: @two, blue: @one }
    end
  end

  def scores
    { red: players[:red].attributes,
      blue: players[:blue].attributes }
  end
end
