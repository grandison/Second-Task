class AddTextToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :text, :string
  end

  def self.down
    remove_column :comments, :text
  end
end

