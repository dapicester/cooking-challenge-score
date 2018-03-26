class AddPenaltyToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :penalty, :float
    add_column :teams, :penalty_reason, :text
  end
end
