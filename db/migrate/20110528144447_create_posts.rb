class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :user_id
      t.integer :category_id
      t.text :topic
      t.text :text
      t.text :source
      t.text :tags
      t.integer :rating

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end

