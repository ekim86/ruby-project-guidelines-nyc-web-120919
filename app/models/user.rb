# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_many :tickets
  has_many :movies, through: :tickets

  # def new_reservations
  #   Reservation.create(user_id: self.id, movie_id: movie.id, ticket_quantity: ticket_quantity)
  # end

end
