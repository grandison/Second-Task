# == Schema Information
# Schema version: 20110528144447
#
# Table name: posts
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  category_id :integer
#  topic       :text
#  text        :text
#  source      :text
#  tags        :text
#  rating      :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :comments, :dependent => :destroy
  validates :user_id,:category_id,:text,:topic, :presence => true
  acts_as_taggable_on :tags
  scope :topic, lambda{|topic| where("topic LIKE ?",'%'+ topic + '%')}
  scope :text, lambda{|text| where("text LIKE ?",'%'+ text + '%')}
  scope :cat_id, lambda{|cat_id| where("category_id" => cat_id)}
end

