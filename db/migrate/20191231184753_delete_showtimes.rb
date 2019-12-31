class DeleteShowtimes < ActiveRecord::Migration[5.0]
  def change
    remove_column(:movies, :showtimes)
  end
end
