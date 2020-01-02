# == Schema Information
#
# Table name: showtimes
#
#  id         :integer          not null, primary key
#  time       :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  movie_id   :integer
#  theater_id :integer
#

class Showtime < ActiveRecord::Base
  belongs_to :movie
  belongs_to :theater
  has_many :tickets

  # to check.. s = Showtime.first
  # s.movie
  # s.theater
  # s.tickets

end

