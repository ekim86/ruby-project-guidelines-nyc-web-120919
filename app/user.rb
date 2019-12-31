class User < ActiveRecord::Base
  has_many :reservations
  has_many :movies, through: :reservations

  # def new_reservations
  #   Reservation.create(user_id: self.id, movie_id: movie.id, ticket_quantity: ticket_quantity)
  # end

end
