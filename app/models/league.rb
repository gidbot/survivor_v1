class League < ApplicationRecord

  DEFAULT_FORMAT = { qb: 1, wr: 1, rb: 1, te: 1, def: 1, k: 1 }

  validates :name, :max_players, presence: true
  belongs_to :commissioner, class_name: :User
  has_many :teams
  has_many :users, through: :teams
  default_scope { includes(:teams) }
  validate :teams_unique

  before_create do
    self.roster_spots ||= DEFAULT_FORMAT
  end

  def teams_unique
    teams.each do |team|
      next if team.valid?
      team.errors.full_messages.each do |msg|
        errors.add(:base, msg)
      end
    end
  end

end
