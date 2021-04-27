class AddIsSevenDayToQuarantines < ActiveRecord::Migration[6.0]
  def change
    add_column :quarantines, :is_seven_day, :boolean
  end
end
