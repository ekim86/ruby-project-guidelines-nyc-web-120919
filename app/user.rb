class User < ActiveRecord::Base
  has_many :reservations
  has_many :movies, through: :reservations

end
