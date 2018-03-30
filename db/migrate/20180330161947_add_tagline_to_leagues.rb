class AddTaglineToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :tagline, :string
  end
end
