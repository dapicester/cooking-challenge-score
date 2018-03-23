class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :team
      with_options default: 0 do
        t.float :taste
        t.float :meal_planning
        t.float :presentation
        t.float :creativity
        t.float :kitchen_cleanliness
      end
      t.timestamps
    end
  end
end
