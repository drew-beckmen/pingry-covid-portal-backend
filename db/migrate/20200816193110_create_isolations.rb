class CreateIsolations < ActiveRecord::Migration[6.0]
  def change
    create_table :isolations do |t|
      t.date :start_isolation
      t.date :date_improving
      t.boolean :fever_free
      t.date :end_date
      t.integer :student_id 

      t.timestamps
    end
  end
end
