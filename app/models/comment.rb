# == Schema Information
# Schema version: 20110528144447
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  post_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end

