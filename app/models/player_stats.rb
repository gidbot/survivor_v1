class PlayerStats < ApplicationRecord
  self.abstract_class = true
  belongs_to :player
end

class PositionPlayersStats < PlayerStats; end
class KickersStats < PlayerStats; end
class DefensesStats < PlayerStats; end