class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :firstname
      t.string :surname
      t.date :dob
      t.boolean :current, :default => true
      t.references :user, index:true, foreign_key: true
      t.timestamps null: false
    end
  end
end
