class Team < ApplicationRecord
  has_many :votes, inverse_of: :team, dependent: :destroy

  validates :name, presence: true

  validates :penalty, numericality: {
    greater_than_or_equal_to: 0, less_than_or_equal_to: 2
  }, allow_nil: true

  validates :penalty_reason, presence: true, if: :penalty?

  def final_vote
    values = votes
      .map { |vote| vote.record.to_a }
      .transpose
      .map { |keys| keys.reduce(&:+).to_f / keys.length }
    Vote::Record.new(*values)
  end

  def final_vote_data
    {
      label: name,
      borderColor: "##{color}",
      data: final_vote.rescaled
    }
  end

  def score
    sum = final_vote.to_a.reduce(:+)
    sum -= penalty.to_f if penalty?
    sum
  end

  rails_admin do
    configure :color, :color
    configure :score
    configure :penalty, :float
    include_fields :name, :description, :color, :score, :penalty, :penalty_reason
    edit do
      exclude_fields :score
    end
    modal do
      exclude_fields :score
    end
  end
end
