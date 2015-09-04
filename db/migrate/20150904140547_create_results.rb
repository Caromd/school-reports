class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.decimal :classmark
      t.decimal :testmark
      t.references :enrollment, index: true, foreign_key: true
      t.references :term, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
