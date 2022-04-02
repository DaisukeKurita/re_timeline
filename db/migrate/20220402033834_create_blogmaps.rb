class CreateBlogmaps < ActiveRecord::Migration[6.0]
  def change
    create_table :blogmaps do |t|
      t.references :blog, null: false, foreign_key: true
      t.references :map, null: false, foreign_key: true

      t.timestamps
    end
  end
end
