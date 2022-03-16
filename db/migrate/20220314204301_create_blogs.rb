class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.integer :new_contributor_id
      t.integer :last_updater_id
      t.string :title
      t.text :content
      t.text :image
      t.datetime :event_date
      t.boolean :notice

      t.timestamps
    end
    add_index :blogs, :new_contributor_id
    add_index :blogs, :last_updater_id
  end
end
