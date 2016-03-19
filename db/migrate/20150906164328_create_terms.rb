class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :year
      t.string :term
      t.date :startdate
      t.date :enddate
      t.boolean :active, :default => true
      t.references :user, index:true, foreign_key: true
      t.timestamps null: false
    end
  end
end
