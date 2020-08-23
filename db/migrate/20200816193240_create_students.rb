class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.integer :grade
      t.string :campus
      t.string :cohort
      t.integer :veracross_id 

      t.timestamps
    end
  end
end
