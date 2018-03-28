class AddEventToCheckin < ActiveRecord::Migration
  def change
    add_reference :checkins, :event, index: true
  end
end
