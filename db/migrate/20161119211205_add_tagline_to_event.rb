class AddTaglineToEvent < ActiveRecord::Migration
  def change
    add_column :events, :tagline, :string
  end
end
