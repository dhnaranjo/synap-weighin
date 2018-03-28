class Checkin < ActiveRecord::Base
  belongs_to :person
  belongs_to :event
  belongs_to :user
end
