class RenameGroupAdministratorColumnToGroupings < ActiveRecord::Migration[6.0]
  def change
    rename_column :groupings, :group_administrator, :admin
  end
end
