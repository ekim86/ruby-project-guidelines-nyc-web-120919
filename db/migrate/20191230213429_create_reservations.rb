class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :movie_id
      t.integer :ticket_quantity

      t.timestamps
    end 
  end
end
