class AddColumnToBlogs < ActiveRecord::Migration[6.0]
  def change
    add_column :blogs, :image, :text
    add_column :blogs, :event_date, :datetime, default: -> { 'NOW()' }, null: false
    add_column :blogs, :notice, :boolean, default: true, null: false
  end
end
