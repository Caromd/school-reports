class AddMark2LabelAndMark2PercentageToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :mark2_label, :string
    add_column :subjects, :mark2_percentage, :integer
  end
end
