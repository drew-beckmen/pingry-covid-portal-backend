class AddEndDateToQuarantines < ActiveRecord::Migration[6.0]
  def change
    add_column :quarantines, :end_date, :date
  end
end
