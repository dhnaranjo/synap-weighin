class CreateUserLocationJoinTable < ActiveRecord::Migration
  def change
    create_table :user_location_joins do |t|
      t.references :location, index: true, null: false
      t.references :user, index: true, null: false
      t.timestamps
    end
  end
end
