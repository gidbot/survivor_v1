class TeamsController < ApplicationController

  before_action :team

  def show
    @roster = team.rosters.where(week: current_week).first
  end

  private

  def team
    @team ||= Team.find(params[:id])
  end

  def current_week
    @current_week ||= Week.current
  end

end