class AddReportRefToResult < ActiveRecord::Migration
  def change
    add_column :results, :report, :reference
  end
end
