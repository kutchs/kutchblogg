class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.float :rating
      t.text :url
      t.datetime :date
      t.text :content
      t.string :title

      t.timestamps
    end
  end
end
