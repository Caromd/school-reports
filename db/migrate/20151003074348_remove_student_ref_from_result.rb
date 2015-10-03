class RemoveStudentRefFromResult < ActiveRecord::Migration
  def change
    remove_column :results, :student, :reference
  end
end
