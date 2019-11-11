class RostersController < ApplicationController

  before_action :roster, except: [:new, :create]

  def edit
  end

  private

  def roster
    @roster ||= Roster.find(params[:id])
  end

end