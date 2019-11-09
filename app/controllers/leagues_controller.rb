class LeaguesController < ApplicationController

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    @league.commissioner = current_user
    @league.users << current_user
    if @league.save
      redirect_to league_path(@league)
    else
      flash[:alert] = @leage.errors.messages.join("\n")
      render '_form'
    end
  end

  def show
    @league = League.find(params[:id])
  end

  private

  def league_params
    params.require('league').permit(
        :name,
        :max_players,
        :group_password
    )
  end

end
