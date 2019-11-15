class Player < ApplicationRecord

  has_many :position_player_stats
  has_many :kicker_stats
  has_many :defense_stats

  enum position: { qb: 0, wr: 1, rb: 2, te: 3, def: 5, k: 6 }
  scope :with_stats, -> { includes(:position_player_stats, :kicker_stats, :defense_stats)}

  def week_stats(week_id = nil)
    week_id ||= Week.current.id
    @stats ||= begin
      case position
      when "def"
        _stats = defense_stats
      when "kicker"
        _stats = kicker_stats
      else
        _stats = position_player_stats
      end
      _stats = _stats.where(week_id: week_id).first
      _stats
    end
  end

end
