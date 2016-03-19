class AddUserIdToMarkPercents < ActiveRecord::Migration
  def change
    add_column :markpercents, :user_id, :integer
  end
end
