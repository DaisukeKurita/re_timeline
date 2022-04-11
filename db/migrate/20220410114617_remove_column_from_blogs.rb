class RemoveColumnFromBlogs < ActiveRecord::Migration[6.0]
  def change
    remove_column :blogs, :address, :string
    remove_column :blogs, :latitude, :float
    remove_column :blogs, :longitude, :float
  end
end
