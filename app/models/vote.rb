class Vote < ApplicationRecord
  belongs_to :team, inverse_of: :votes

  validates :taste, presence: true, numericality: {
    greater_than_or_equal_to: 0, less_than_or_equal_to: 3
  }

  validates :meal_planning, presence: true, numericality: {
    greater_than_or_equal_to: 0, less_than_or_equal_to: 3
  }

  validates :presentation, presence: true, numericality: {
    greater_than_or_equal_to: 0, less_than_or_equal_to: 2
  }

  validates :creativity, presence: true, numericality: {
    greater_than_or_equal_to: 0, less_than_or_equal_to: 1
  }

  validates :kitchen_cleanliness, presence: true, numericality: {
    greater_than_or_equal_to: 0, less_than_or_equal_to: 1
  }
end
