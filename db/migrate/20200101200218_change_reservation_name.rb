class ChangeReservationName < ActiveRecord::Migration[5.0]
  def change
    rename_table :reservations, :tickets
  end
end
