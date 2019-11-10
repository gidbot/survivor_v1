class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_person_name

  has_many :notifications, foreign_key: :recipient_id
  has_many :services
  # Default Implementation ^

  has_many :teams
  has_and_belongs_to_many :leagues, through: :teams

end
