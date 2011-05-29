class CreateUserVotes < ActiveRecord::Migration
  def self.up
    create_table :user_votes,:id => false do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_votes
  end
end

