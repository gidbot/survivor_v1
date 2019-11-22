class LeaguesController < ApplicationController

  before_action :league, except: [:new, :create, :join, :add_user]
  before_action :validate_add_user, only: [:add_user]

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    @league.commissioner = current_user
    @league.teams.build(user: current_user, name: "#{current_user.name}'s Team")
    if @league.save
      redirect_to league_path(@league)
    else
      flash[:alert] = @league.errors.full_messages.join("<br>").html_safe
      render '_form'
    end
  end

  def join
    @league = League.new
  end

  def add_user
    if @league.errors.empty? && @league.save
      flash[:success] = "Joined League!"
      redirect_to league_path(@league)
    else
      @league.group_password = nil
      flash[:alert] = @league.errors.full_messages.join("<br>").html_safe
      render 'join'
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
        :group_password,
        :id
    )
  end

  def validate_add_user
    @league = League.find_by_id(league_params[:id])
    if @league.present?
      if @league.group_password.blank? || @league.group_password == league_params[:group_password]
        @league.teams.build(user: current_user, name: "#{current_user.name}'s Team")
        @league.validate
      else
        @league.errors.add(:base, "League Passcode Incorrect")
      end
    else
      @league = League.new
      @league.errors.add(:base, "League ID Not Found")
    end
    @league
  end

end
