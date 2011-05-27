class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :topic
      t.text :text
      t.string :source
      t.string :tags
      t.integer :rating

      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end
