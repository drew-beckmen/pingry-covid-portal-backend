class AddRecentRecoveryToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :recent_recovery, :boolean
  end
end
