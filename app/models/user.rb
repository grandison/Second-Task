class User < ActiveRecord::Base
  has_many :news
  has_many :comments
end

