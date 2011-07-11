class AddApproveToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :approve, :integer
  end

  def self.down
    remove_column :comments, :approve
  end
end

