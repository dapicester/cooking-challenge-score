class Team < ApplicationRecord
  has_many :votes, inverse_of: :team, dependent: :destroy

  validates :name, presence: true
end
