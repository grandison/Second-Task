# == Schema Information
# Schema version: 20110527100430
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  validates :name, :presence => true
  acts_as_tree
end

