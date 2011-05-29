# == Schema Information
# Schema version: 20110528171532
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  post_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  text       :string(255)
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :text,:presence => true
end

