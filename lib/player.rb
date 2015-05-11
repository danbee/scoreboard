class Player
  include Redis::Objects

  attr_reader :id

  value :name
  counter :score
  counter :games

  def initialize(id, attr = {})
    @id = id
    self.name = attr[:name]
  end

  def has_beaten(player)
    self.score.value > 10 && self.score.value > player.score.value + 1
  end

  def attributes
    { name: self.name.value,
      score: self.score.value,
      games: self.games.value }
  end
end
