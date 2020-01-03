class DeleteMovieIdAddUserId < ActiveRecord::Migration[5.0]
  def change
    remove_column :tickets, :movie_id, :integer
    add_column :tickets, :user_id, :integer
  end
end
