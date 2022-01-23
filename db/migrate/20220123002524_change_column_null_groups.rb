class ChangeColumnNullGroups < ActiveRecord::Migration[6.0]
  def change
    change_column :groups, :name, :string, null: false
  end
end
