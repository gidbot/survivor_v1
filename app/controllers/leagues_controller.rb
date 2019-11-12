class LeaguesController < ApplicationController

  before_action :league, except: [:new, :create]

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    @league.commissioner = current_user
    @league.teams << Team.new(user: current_user, name: "#{current_user.name}'s Team")
    if @league.save
      redirect_to league_path(@league)
    else
      flash[:alert] = @league.errors.messages.join("\n")
      render '_form'
    end
  end

  private

  def league
    @league ||= League.find(params[:id])
  end

  def league_params
    params.require('league').permit(
        :name,
        :max_players,
        :group_password
    )
  end

end
