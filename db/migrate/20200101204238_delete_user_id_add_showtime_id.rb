class DeleteUserIdAddShowtimeId < ActiveRecord::Migration[5.0]
  def change
    remove_column :tickets, :user_id, :integer
    add_column :tickets, :showtime_id, :integer
  end
end
