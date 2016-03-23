class RemoveGradeIdFromMarkpercents < ActiveRecord::Migration
  def change
    remove_column :markpercents, :grade_id, :integer
  end
end
