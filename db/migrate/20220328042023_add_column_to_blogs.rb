class AddColumnToBlogs < ActiveRecord::Migration[6.0]
  def change
    add_column :blogs, :photo, :text
    add_column :blogs, :event_date, :datetime, default: -> { 'NOW()' }, null: false
    add_column :blogs, :email_notice, :boolean, default: true, null: false
  end
end
