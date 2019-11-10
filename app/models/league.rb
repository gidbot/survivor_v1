class League < ApplicationRecord

  DEFAULT_FORMAT = { qb: 1, wr: 1, rb: 1, te: 1, def: 1, k: 1 }

  validates :name, :max_players, presence: true
  belongs_to :commissioner, class_name: :User
  has_many :teams
  has_and_belongs_to_many :users, through: :teams

  before_create do
    self.positions ||= DEFAULT_FORMAT
  end

end
