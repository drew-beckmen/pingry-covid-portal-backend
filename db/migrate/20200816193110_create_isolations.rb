class CreateIsolations < ActiveRecord::Migration[6.0]
  def change
    create_table :isolations do |t|
      t.date :start_isolation
      t.date :date_improving
      t.boolean :fever_free
      t.boolean :confirmed
      t.date :end_date
      t.boolean :completed
      t.integer :student_id 
      t.string :notes 

      t.timestamps
    end
  end
end
