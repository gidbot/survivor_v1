class Team < ApplicationRecord

  belongs_to :league
  belongs_to :user
  has_many :rosters

  before_create :create_rosters
  after_find :set_used_players
  attr_accessor :used_players

  private

  def create_rosters
    number = Week.current.number
    Week.where("number >= ?", number).each do |w|
      self.rosters.build(week: w)
    end
  end

  def set_used_players
    self.used_players = rosters.map { |roster| roster.roster_spots.values }.flatten.compact
  end

end