class AddLeagueReferenceToPerson < ActiveRecord::Migration
  def change
    add_reference :people, :league, index: true
  end
end
