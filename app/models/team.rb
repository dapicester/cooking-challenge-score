class Team < ApplicationRecord
  has_many :votes, inverse_of: :team, dependent: :destroy

  validates :name, presence: true

  def final_vote
    # TODO: cache
    avg = ->(col) { "AVG(#{col}) as #{col}" }
    votes.select(
      avg[:taste],
      avg[:meal_planning],
      avg[:presentation],
      avg[:creativity],
      avg[:kitchen_cleanliness]
    ).group(:id).first # Postgresql requires the explicit GROUP BY id
  end

  def final_vote_data
    {
      label: name,
      borderColor: "##{color}",
      data: final_vote.record.rescaled
    }
  end

  def score
    final_vote.record.to_a.reduce(:+)
  end

  rails_admin do
    configure :color, :color
    configure :score
    include_fields :name, :color, :score
    edit do
      exclude_fields :score
    end
    modal do
      exclude_fields :score
    end
  end
end
