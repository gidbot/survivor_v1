class CsvProcessJob < ApplicationJob
  queue_as :default

  def perform(enumerator, week_id, player_type)
    begin
      enumerator.each do |row|
        player_hash = row.to_hash
        player = Player.find_or_create_by(name: player_hash["player"],
                                          position: player_hash["position"].downcase,
                                          team: player_hash["team"],
                                          number: 87)
        player_hash.delete("player")
        player_hash.delete("position")
        player_hash.delete("team")


        case player
        when "defense"
          klass = DefensesStats
        when "kicker"
          klass = KickersStats
        else
          klass = PositionPlayersStats
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