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

  # TODO: make this out of the validation rules
  ATTR_NAMES = %i(taste meal_planning presentation creativity kitchen_cleanliness)
  MAX_VALUES = [3, 3, 2, 1, 1]
  # normalize to mcm of (3, 2, 1) = 6
  SCALE_FACTORS = [2, 2, 3, 6, 6]

  Record = Struct.new(*ATTR_NAMES) do
    def initialize(taste = 0, meal_planning = 0, presentation = 0, creativity = 0, kitchen_cleanliness = 0)
      super
    end

    def rescaled
      self.to_a.zip(SCALE_FACTORS).map { |val, k| val * k }
    end
  end

  def record
    values = attributes.values_at(*ATTR_NAMES.map(&:to_s))
    Record.new(*values)
  end

  rails_admin do
     exclude_fields :id, :created_at, :updated_at
  end
end
