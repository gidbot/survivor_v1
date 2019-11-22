class TeamsController < ApplicationController

  before_action :team

  def show
    @rosters = team.rosters.includes(:week).order("weeks.number")
  end

  private

  def team
    @team ||= Team.find(params[:id])
  end

  def current_week
    @current_week ||= Week.current
  end

end