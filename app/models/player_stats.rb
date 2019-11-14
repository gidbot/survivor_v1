class PlayerStats < ApplicationRecord
  self.abstract_class = true
  belongs_to :player
  attr_accessor :score_map
  def score
    _score = 0
    score_map.each do |statistic, multiplier|
      _score += self[statistic] * multiplier
    end
    _score
  end

  def set_score_map(map)
    self.score_map = map
  end
end

class PositionPlayersStats < PlayerStats
  after_find do
    self.set_score_map({
                      pass_yards: 0.04,
                      pass_tds: 6,
                      interceptions: -2,
                      rush_yards: 0.10,
                      rush_tds: 6,
                      receptions: 0.5,
                      rec_yards: 0.10,
                      return_tds: 6,
                      # other_tds: 6,
                      # two_points: 2,
                      fumbles_lost: -2
                  })
  end
end

class KickersStats < PlayerStats
  #  set_score_map({
  #     inside_20: 3,
  #     twenties: 3,
  #     thirties: 3,
  #     fourties: 4,
  #     fifties: 5,
  #     pat: 1,
  #     missed: -1
  # })
end

class DefensesStats < PlayerStats
  # set_score_map({
  #     sacks: 1,
  #     ints: 2,
  #     fumble_recoveries: 2,
  #     touchdowns: 6,
  #     safeties: 2,
  #     blocked_kicks: 2,
  #     return_tds: 6
  # })

  def score
    _score = super()
    fantasy_points = 0
    case points_allowed
    when 0
      10
    when 1..6
      7
    when 7..13
      4
    when 14-20
      1
    when 21..27
      0
    when 28..34
      -1
    else
      -4
    end
    _score += fantasy_points
    _score
  end
end