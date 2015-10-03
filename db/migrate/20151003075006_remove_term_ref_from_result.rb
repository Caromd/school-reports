class RemoveTermRefFromResult < ActiveRecord::Migration
  def change
    remove_column :results, :term, :reference
  end
end
