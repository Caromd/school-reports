class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.string :grade
      t.string :year
      t.references :student, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
