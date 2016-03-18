class AddColumnToMarkPercent < ActiveRecord::Migration
  def change
    add_column :markpercents, :subject_id, :integer
    add_column :markpercents, :grade_id, :integer
    add_column :markpercents, :mark1_label, :string
    add_column :markpercents, :mark1_percentage, :integer
    add_column :markpercents, :mark2_label, :string
    add_column :markpercents, :mark2_percentage, :integer
  end
end
