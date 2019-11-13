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
      enumerator = CSV.foreach(params[:file].path, headers: true)
      CsvProcessJob.perform_now(enumerator)
    end
  end
end