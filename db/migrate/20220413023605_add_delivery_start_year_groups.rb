class AddDeliveryStartYearGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :delivery_start_year, :date
  end
end
