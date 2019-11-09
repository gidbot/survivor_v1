class League < ApplicationRecord

  validates :name, :max_players, presence: true
  belongs_to :commissioner, class_name: :User
  has_and_belongs_to_many :users

end
