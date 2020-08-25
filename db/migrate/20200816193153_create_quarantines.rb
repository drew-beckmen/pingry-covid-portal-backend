class CreateQuarantines < ActiveRecord::Migration[6.0]
  def change
    create_table :quarantines do |t|
      t.date :exposure
      t.boolean :converted_to_isolation
      t.boolean :completed
      t.integer :student_id 
      t.string :notes

      t.timestamps
    end
  end
end
