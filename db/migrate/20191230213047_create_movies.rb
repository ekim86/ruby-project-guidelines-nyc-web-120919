class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :synopsis
      t.string :showtimes
      t.string :content_rating
      
      t.timestamps
    end 
  end
end
