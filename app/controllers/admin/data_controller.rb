module Admin
  class DataController < Admin::ApplicationController
    require 'csv'
    def edit_players
    end

    def update_players
    end

    def edit_stats
    end

    def update_stats
      week_id = Week.find(params[:week][:id]).id
      enumerator = CSV.foreach(params[:file].path, headers: true)
      if CsvProcessJob.perform_now(enumerator, week_id, params[:player][:type])
        flash[:success] = "stats uploaded"
      else
        flash[:alert] = "Something went wrong. Check your shit."
      end
      redirect_back(fallback_location: root_path)
    end
  end
end