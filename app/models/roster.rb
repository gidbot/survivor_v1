class Roster < ApplicationRecord

  belongs_to :team
  belongs_to :week
  before_create :build_positions

  private

  def build_positions
    self.positions = {}
    self.team.league.positions.each do |key, value|
      for i in (1..value) do
        self.positions["#{key}_#{i}"] = nil
      end
    end
  end

end