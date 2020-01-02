# == Schema Information
#
# Table name: theaters
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Theater < ActiveRecord::Base
  has_many :showtimes
  has_many :movies, through: :showtimes

end

