# == Schema Information
# Schema version: 20110528144447
#
# Table name: posts
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  category_id :integer
#  topic       :string(255)
#  text        :text
#  source      :string(255)
#  tags        :string(255)
#  rating      :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :comments
end

