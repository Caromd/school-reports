class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.integer :term
      t.date :startdate
      t.date :enddate
      t.references :schoolyear, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
