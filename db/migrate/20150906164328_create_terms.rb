class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :year
      t.string :term
      t.date :startdate
      t.date :enddate

      t.timestamps null: false
    end
  end
end
