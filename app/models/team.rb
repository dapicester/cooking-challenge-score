class Team < ApplicationRecord
  has_many :votes, inverse_of: :team, dependent: :destroy

  validates :name, presence: true

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
    final_vote.to_a.reduce(:+)
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
