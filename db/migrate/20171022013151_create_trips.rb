class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.string :name
      t.string :budget
      t.integer :travelers
      t.integer :user_id
    end
  end
end
