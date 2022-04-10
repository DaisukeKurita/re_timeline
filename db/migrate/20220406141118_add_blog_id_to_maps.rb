class AddBlogIdToMaps < ActiveRecord::Migration[6.0]
  def change
    add_reference :maps, :blog, null: false, foreign_key: true
  end
end
