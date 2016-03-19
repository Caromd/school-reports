class CreateMarkpercents < ActiveRecord::Migration
  def change
    create_table :markpercents do |t|
      t.string :mark1_label
      t.integer :mark1_percentage
      t.string  :mark2_label
      t.integer  :mark2_percentage
      t.references :subject, index: true, foreign_key: true
      t.references :grade, index: true, foreign_key: true
      t.references :user, index:true, foreign_key: true
      t.timestamps null: false
    end
  end
end
