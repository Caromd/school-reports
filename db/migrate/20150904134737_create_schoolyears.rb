class CreateSchoolyears < ActiveRecord::Migration
  def change
    create_table :schoolyears do |t|
      t.integer :year

      t.timestamps null: false
    end
  end
end
