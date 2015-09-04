class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :firstname
      t.string :surname
      t.date :dob

      t.timestamps null: false
    end
  end
end
