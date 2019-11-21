class Roster < ApplicationRecord

  belongs_to :team
  belongs_to :week
  before_create :build_roster_spots

  default_scope { includes(:week, :team) }

  def players
    @players ||= begin
      player_ids = roster_spots.values.flatten.select(&:present?)
      _players = Player.find(player_ids)
      roster_spots.keys.map do |roster_position|
        roster_spots[roster_position].map do |roster_spot|
          player = _players.detect{|p| p.id.to_s == roster_spot.to_s}
          { roster_position: roster_position, player: player, score: player&.week_stats(week)&.score}
        end
      end.flatten
    end
  end

  def calculate_score
     players.reduce(0){|total, p| total + (p[:score] || 0)}.round(2)
  end

  private

  def build_roster_spots
    self.roster_spots = {}
    self.team.league.roster_spots.each do |key, value|
      self.roster_spots["#{key}"] = Array.new(value)
    end
  end

end