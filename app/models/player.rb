class Player < ApplicationRecord

  has_many :position_player_stats
  has_many :kickers_stats
  has_many :defenses_stats

  scope :with_stats, -> { includes(:position_player_stats, :kickers_stats, :defenses_stats)}

  def week_stats
    case position
    when "def"
      defenses_stats
    when "kicker"
      kickers_stats
    else
      position_player_stats
    end
  end

end
