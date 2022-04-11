class AddGroupIdToMaps < ActiveRecord::Migration[6.0]
  def change
    add_reference :maps, :group, null: false, foreign_key: true
  end
end
