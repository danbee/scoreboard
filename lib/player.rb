class Player
  attr_reader :score, :games

  def initialize
    @score = 0
    @games = 0
  end

  def has_beaten(player)
    @score > 10 && @score > player.score + 1
  end

  def add_point
    @score += 1
  end

  def undo_point
    @score -= 1
  end

  def attributes
    { score: @score, games: @games }
  end
end
