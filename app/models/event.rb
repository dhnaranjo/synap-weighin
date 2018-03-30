class Event < ActiveRecord::Base
  default_scope { order(created_at: :asc) }

  has_many :checkins
  has_many :people, -> { distinct }, through: :checkins
  has_many :leagues, -> { distinct }, through: :people

end
