class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.references :student, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.references :schoolyear, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
