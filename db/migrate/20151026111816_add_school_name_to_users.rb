class AddSchoolNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :schoolname, :string
  end
end
