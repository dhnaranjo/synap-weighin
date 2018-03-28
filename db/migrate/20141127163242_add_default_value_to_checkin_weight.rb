class AddDefaultValueToCheckinWeight < ActiveRecord::Migration
  def up
    change_column :checkins, :weight, :decimal, :default => 0
  end

  def down
    change_column :checkins, :weight, :decimal, :default => nil
  end
end
