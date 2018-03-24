class DasboardController < ApplicationController
  def index
    @teams = Team.all
    @data = {
      labels: %w(
        Taste
        Meal\ Planning
        Presentation
        Creativity
        Kitchen\ Cleanliness
      ),
      datasets: @teams.map(&:final_vote_data),
      meta: {
        maxValues: Vote::MAX_VALUES,
        scaleFactors: Vote::SCALE_FACTORS
      }
    }
  end
end
