class Team < ApplicationRecord

  belongs_to :league
  belongs_to :user
  has_many :rosters

  before_create :create_rosters

  private

  def create_rosters
    number = Week.current.number
    Week.where("number >= ?", number).each do |w|
      self.rosters.build(week: w)
    end
  end

end