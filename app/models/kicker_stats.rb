class KickerStats < PlayerStats
   SCORE_MAP = {
      inside_20: 3,
      twenties: 3,
      thirties: 3,
      fourties: 4,
      fifties: 5,
      pat: 1,
      missed: -1
  }

   after_find do
     set_score_map(SCORE_MAP)
   end

end