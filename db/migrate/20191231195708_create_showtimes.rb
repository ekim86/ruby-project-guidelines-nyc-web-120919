class CreateShowtimes < ActiveRecord::Migration[5.0]
  def change
    create_table :showtimes do |t|
      t.datetime :time

      t.timestamps
    end
  end
end
