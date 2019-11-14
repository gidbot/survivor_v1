class Roster < ApplicationRecord

  belongs_to :team
  belongs_to :week
  before_create :build_roster_spots

  default_scope { includes(:week, :team) }

  def players
    @players ||= begin
      roster_spots.keys.map do |roster_position|
        player = Player.find_by_id(roster_spots[roster_position])
        { roster_position: roster_position, player: player, score: player.week_stats(week).score}
      end
    end
  end

  private

  def build_roster_spots
    self.roster_spots = {}
    self.team.league.roster_spots.each do |key, value|
      self.roster_spots["#{key}"] = Array.new(value)
    end
  end

end