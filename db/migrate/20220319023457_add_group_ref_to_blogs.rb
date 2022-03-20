class AddGroupRefToBlogs < ActiveRecord::Migration[6.0]
  def change
    add_reference :blogs, :group, null: false, foreign_key: true
  end
end
