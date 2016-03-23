class AddLevelToMarkpercents < ActiveRecord::Migration
  def change
    add_reference :markpercents, :level, index: true, foreign_key: true
  end
end
