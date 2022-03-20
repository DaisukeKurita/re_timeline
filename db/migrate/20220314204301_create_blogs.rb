class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.integer :new_contributor_id, null: false
      t.integer :last_updater_id
      t.string :title, null: false
      t.text :content

      t.timestamps
    end
    add_index :blogs, :new_contributor_id
    add_index :blogs, :last_updater_id
  end
end
