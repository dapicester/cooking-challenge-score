class Team < ApplicationRecord
  has_many :votes, inverse_of: :team, dependent: :destroy

  validates :name, presence: true

  def final_vote
    avg = ->(col) { "AVG(#{col}) as #{col}" }
    votes.select(
      avg[:taste],
      avg[:meal_planning],
      avg[:presentation],
      avg[:creativity],
      avg[:kitchen_cleanliness]
    ).first
  end

  def final_vote_data
    {
      label: name,
      data: final_vote.record.rescaled
    }
  end

  def score
    final_vote.record.to_a.reduce(:+)
  end
end
