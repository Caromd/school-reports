class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.decimal :classmark
      t.decimal :testmark
      t.text :comment
      t.references :report, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.references :user, index:true, foreign_key: true
      t.timestamps null: false
    end
  end
end
