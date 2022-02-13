class AddIndexToGroupings < ActiveRecord::Migration[6.0]
  def change
    add_index :groupings, [:user_id, :group_id], unique: true
  end
end
