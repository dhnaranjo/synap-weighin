class AddStartingWeightAndUpByToPerson < ActiveRecord::Migration
  def change
    add_column :people, :starting_weight, :decimal
    add_column :people, :up_by, :decimal
  end
end
