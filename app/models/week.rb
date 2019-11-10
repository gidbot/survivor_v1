class Week < ApplicationRecord

  has_many :rosters
  scope :current, -> { where(current: true).first }

end