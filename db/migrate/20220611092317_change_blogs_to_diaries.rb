class ChangeBlogsToDiaries < ActiveRecord::Migration[6.0]
  def change
    rename_table :blogs, :diaries
  end
end
