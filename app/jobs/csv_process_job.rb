class CsvProcessJob < ApplicationJob
  queue_as :default

  def perform(enumerator, week_id)
    begin
      enumerator.each do |row|
        player_hash = row.to_hash
        player = Player.find_or_create_by(name: player_hash["name"],
                                          position: player_hash["position"].downcase,
                                          team: player_hash["team"],
                                          number: 87)
        player_hash.delete("name")
        player_hash.delete("position")
        player_hash.delete("team")


        case player.position
        when "def"
          klass = DefenseStats
        when "k"
          klass = KickerStats
        else
          klass = PositionPlayerStats
        end
        stats = klass.find_or_create_by(week_id: week_id, player_id: player.id)
        stats.update_attributes(player_hash)
      end
      true
    rescue Exception => error
      false
    end
  end
end