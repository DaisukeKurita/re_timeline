class ChangeDataEventDateToBlogs < ActiveRecord::Migration[6.0]
  def change
    change_column :blogs, :event_date, :date
  end
end
