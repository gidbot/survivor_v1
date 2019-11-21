class UpdateStatsJob < ApplicationJob
  queue_as :default

  def perform(week_id)
    Roster.where(week_id: week_id).each do |roster|
      roster.score = roster.calculate_score
      roster.save
    end
    Team.all.each do |team|
      team.score = team.calculate_score
      team.save
    end
  end
end