# == Schema Information
#
# Table name: tickets
#
#  id              :integer          not null, primary key
#  ticket_quantity :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  showtime_id     :integer
#  user_id         :integer
#

class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :showtime
  has_one :movie, through: :showtime
  has_one :theater, through: :showtime
  # because each ticket will have one movie

end

