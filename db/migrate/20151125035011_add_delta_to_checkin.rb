class AddDeltaToCheckin < ActiveRecord::Migration
  def change
    add_column :checkins, :delta, :decimal
  end
end
