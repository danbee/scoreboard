class Player
  include Redis::Objects

  counter :score
  counter :games

  def initialize(name)
    @name = name
  end

  def has_beaten(player)
    self.score.value > 10 && self.score.value > player.score.value + 1
  end

  def attributes
    { name: @name,
      score: self.score.value,
      games: self.games.value }
  end

  def id
    @name.downcase.gsub(/[^a-z]/, '-')
  end
end
