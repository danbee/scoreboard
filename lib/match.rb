class Match
  def initialize(name_one = nil, name_two = nil)
    @one, @two = Player.new(:one),
                 Player.new(:two)
    @one.name = name_one unless name_one.nil?
    @two.name = name_two unless name_two.nil?
  end

  def add_point(colour)
    players[colour].score.increment
    if @one.has_beaten(@two)
      reset_scores
      @one.games.increment
    elsif @two.has_beaten(@one)
      reset_scores
      @two.games.increment
    end
  end

  def undo_point(colour)
    player = players[colour]
    player.score.decrement if player.score.value > 0
  end

  def reset_scores
    @one.score.reset
    @two.score.reset
  end

  def reset_games
    @one.games.reset
    @two.games.reset
  end

  def total_games
    @one.games.value + @two.games.value
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
