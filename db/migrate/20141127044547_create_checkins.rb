class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.decimal :weight
      t.references :person, index: true

      t.timestamps
    end
  end
end
