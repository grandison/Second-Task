# == Schema Information
# Schema version: 20110718170354
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  parent_id  :integer
#

class Category < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  validates :name, :presence => true
  validate :presence_of_parent
  acts_as_tree
  def presence_of_parent
    errors.add(:parent_id, 'is not a valid parent') if !parent&&parent_id
  end
end

