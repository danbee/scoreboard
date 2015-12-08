class Match
  include Redis::Objects

  value :initial_serve
  value :serve

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
      swap_initial_serve
      @one.games.increment
    elsif @two.has_beaten(@one)
      reset_scores
      swap_initial_serve
      @two.games.increment
    end
    set_serve
  end

  def set_serve
    total_points = @one.score.value + @two.score.value

    if @one.score.value >= 10 && @two.score.value >= 10
      initial_server = total_points.even?
    else
      initial_server = (total_points / 2).even?
    end

    case self.initial_serve.value
    when 'blue'
      self.serve = initial_server ? :blue : :red
    when 'red'
      self.serve = initial_server ? :red : :blue
    end
  end

  def swap_initial_serve
    case self.initial_serve.value
    when 'red'
      set_initial_serve(:blue)
    when 'blue'
      set_initial_serve(:red)
    end
  end

  def undo_point(colour)
    player = players[colour]
    if player.score.value > 0
      player.score.decrement
    elsif no_scores?
      set_initial_serve(colour)
    end
  end

  def set_initial_serve(colour)
    self.initial_serve = colour
    self.serve = colour
  end

  def reset_scores
    @one.score.reset
    @two.score.reset
  end

  def reset_games
    @one.games.reset
    @two.games.reset
    set_initial_serve(nil)
  end

  def total_games
    @one.games.value + @two.games.value
  end

  def players
    if total_games.even?
      { red: @two, blue: @one }
    else
      { red: @one, blue: @two }
    end
  end

  def scores
    { red: players[:red].attributes.merge(serve: self.serve == 'red'),
      blue: players[:blue].attributes.merge(serve: self.serve == 'blue') }
  end

  def no_scores?
    @one.score == 0 && @two.score == 0
  end

  # This is required for Redis
  def id
    1
  end
end
