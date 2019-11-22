class Team < ApplicationRecord

  belongs_to :league
  belongs_to :user
  has_many :rosters
  before_create :create_rosters
  validates :league_id, uniqueness: { scope: :user_id, message: "user is already in league" }

  def used_players(exclude = nil)
    @used_players ||= rosters.reject{|r| r.id == exclude}.map { |roster| roster.roster_spots.values.flatten.select(&:present?)}.flatten
  end

  def calculate_score
    rosters.reduce(0){|total, p| total + (p[:score] || 0)}.round(2)
  end

  private

  def create_rosters
    number = Week.current.number
    Week.where("number >= ?", number).each do |w|
      self.rosters.build(week: w)
    end
  end

end