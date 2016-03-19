class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :teacher
      t.text :teacher_comment
      t.string :principal
      t.text :principal_comment
      t.references :student, index: true, foreign_key: true
      t.references :term, index: true, foreign_key: true
      t.references :user, index:true, foreign_key: true
      t.timestamps null: false
    end
  end
end
