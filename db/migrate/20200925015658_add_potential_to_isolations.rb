class AddPotentialToIsolations < ActiveRecord::Migration[6.0]
  def change
    add_column :isolations, :potential, :boolean
  end
end
