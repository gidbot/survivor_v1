class Player < ApplicationRecord

  has_many :position_players_stats
  has_many :kickers_stats
  has_many :defenses_stats

  enum position: { qb: 0, wr: 1, rb: 2, te: 3, def: 5, k: 6 }
  scope :with_stats, -> { includes(:position_player_stats, :kickers_stats, :defenses_stats)}

  def week_stats(week_id)
    @stats ||= begin
      case position
      when "def"
        _stats = defenses_stats
      when "kicker"
        _stats = kickers_stats
      else
        _stats = position_players_stats
      end
      _stats = _stats.where(week_id: week_id).first
      _stats
    end
  end

end
