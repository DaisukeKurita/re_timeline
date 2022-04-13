class AddReceivingDateGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :receiving_date, :integer, null: false, default: 0
  end
end
