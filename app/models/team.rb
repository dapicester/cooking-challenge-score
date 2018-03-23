class Team < ApplicationRecord
  has_many :votes, inverse_of: :team, dependent: :destroy

  validates :name, presence: true

  def score
    avg = ->(col) { "AVG(#{col}) as #{col}" }
    votes.select(
      avg[:taste],
      avg[:meal_planning],
      avg[:presentation],
      avg[:creativity],
      avg[:kitchen_cleanliness]
    ).first
  end
end
