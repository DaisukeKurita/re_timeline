class RenameBlogColumnToMaps < ActiveRecord::Migration[6.0]
  def change
    rename_column :maps, :blog_id, :diary_id
  end
end
