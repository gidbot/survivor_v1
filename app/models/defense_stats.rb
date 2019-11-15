class DefenseStats < PlayerStats
  SCORE_MAP = {
      sacks: 1,
      interceptions: 2,
      fumble_recoveries: 2,
      touchdowns: 6,
      safeties: 2,
      blocked_kicks: 2,
      return_tds: 6
  }

  after_find do
    set_score_map(SCORE_MAP)
  end

  def score
    fantasy_points = begin
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
    end
    super(fantasy_points)
  end
end