class RostersController < ApplicationController

  before_action :roster, except: [:new, :create]

  def edit
  end

  def update
    binding.pry
    if roster.update(roster_params)
      flash[:success] = "Roster Saved"
      redirect_to roster_path(roster)
    else
      flash[:alert] = roster.errors.messages.join("\n")
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def roster
    @roster ||= Roster.find(params[:id])
  end

  def roster_params
    params.require(:roster).permit(roster_spots: { qb:[], wr:[], rb:[], te:[], def:[], k:[] })
  end

end