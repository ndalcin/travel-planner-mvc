class CreateFlights < ActiveRecord::Migration[5.1]
  def change
    create_table :flights do |t|
      t.string :departure_city
    end
  end
end
