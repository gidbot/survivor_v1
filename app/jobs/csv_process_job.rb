class CsvProcessJob < ApplicationJob
  queue_as :default

  def perform(enumerator)
    enumerator.each do |row|
      player_hash = row.to_hash
    end
  end
end