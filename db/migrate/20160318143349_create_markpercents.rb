class CreateMarkpercents < ActiveRecord::Migration
  def change
    create_table :markpercents do |t|

      t.timestamps null: false
    end
  end
end
