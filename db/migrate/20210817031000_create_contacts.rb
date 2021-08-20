class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.date :exposure
      t.integer :student_id 
      t.string :notes
      t.timestamps
    end
  end
end
