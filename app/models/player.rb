class Player < ApplicationRecord

  has_many :position_players_stats
  has_many :kickers_stats
  has_many :defenses_stats

  enum position: { qb: 0, wr: 1, rb: 2, te: 3, def: 5, k: 6 }
  scope :with_stats, -> { includes(:position_player_stats, :kickers_stats, :defenses_stats)}

  def stats(week = nil)
    @stats ||= begin
      case position
      when "def"
        _stats = defenses_stats
      when "kicker"
        _stats = kickers_stats
      else
        _stats = position_players_stats
      end
      _stats.where(week: week) if week.present?
    end
  end

end
