class AddUserPersonJoins < ActiveRecord::Migration
  def change
    create_table :user_person_joins do |t|
      t.references :person, index: true, null: false
      t.references :user, index: true, null: false
      t.timestamps
    end
  end
end
