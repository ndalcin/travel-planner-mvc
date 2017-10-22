class CreateFlights < ActiveRecord::Migration[5.1]
  def change
    create_table :flights do |t|
      t.string :departure
      t.string :arrival
      t.integer :trip_id
    end
  end
end
