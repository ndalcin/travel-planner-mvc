class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.string :budget
      t.string :length
      t.integer :user_id
    end
  end
end
