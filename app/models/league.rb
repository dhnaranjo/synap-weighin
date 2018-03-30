class League < ActiveRecord::Base

  has_many :people
  has_many :checkins, through: :people
  has_many :events, -> { distinct }, through: :checkins

end
