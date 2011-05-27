# == Schema Information
# Schema version: 20110527100430
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  new_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :new
end

