# == Schema Information
#
# Table name: movies
#
#  id             :integer          not null, primary key
#  title          :string
#  synopsis       :string
#  content_rating :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Movie < ActiveRecord::Base
  has_many :showtimes
  has_many :tickets
  has_many :theaters, through: :showtimes
  has_many :users, through: :tickets

end
