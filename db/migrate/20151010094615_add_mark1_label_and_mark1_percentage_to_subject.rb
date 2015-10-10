class AddMark1LabelAndMark1PercentageToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :mark1_label, :string
    add_column :subjects, :mark1_percentage, :integer
  end
end
