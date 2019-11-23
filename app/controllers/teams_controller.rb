class TeamsController < ApplicationController

  before_action :team
  before_action :validate_user

  def show
    @rosters = team.rosters.includes(:week).order("weeks.number")
  end

  def edit; end

  def update
    if team.update(team_params)
      flash[:success] = "Team name changed"
      redirect_to team_path(@team)
    else
      flash[:alert] = team.errors.full_messages.join("<br>").html_safe
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def validate_user
    redirect_to '/', alert: 'Not authorized.' unless (user_signed_in? && current_user.admin?) || (@team.user == current_user)
  end

  def team
    @team ||= Team.find(params[:id])
  end

  def current_week
    @current_week ||= Week.current
  end

  def team_params
    params.require('team').permit(
        :name
    )
  end

end