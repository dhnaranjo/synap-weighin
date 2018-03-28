class AddTimesUsedToUserPersonJoin < ActiveRecord::Migration
  def change
    add_column :user_person_joins, :times_used, :integer, default: 1
  end
end
