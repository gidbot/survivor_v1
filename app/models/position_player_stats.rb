class PositionPlayerStats < PlayerStats
  SCORE_MAP = {
       pass_yards: 0.04,
       pass_tds: 6,
       interceptions: -2,
       rush_yards: 0.10,
       rush_tds: 6,
       receptions: 0.5,
       rec_yards: 0.10,
       return_tds: 6,
       other_tds: 6,
       two_points: 2,
       fumbles_lost: -2
  }

  after_find do
    set_score_map(SCORE_MAP)
  end

end