class PlayerStats < ApplicationRecord
  self.abstract_class = true
  belongs_to :player
  attr_accessor :score_map
  def score(_score = 0)
    score_map.each do |statistic, multiplier|
      _score += self[statistic] * multiplier
    end
    _score
  end

  def set_score_map(map)
    self.score_map = map
  end
end