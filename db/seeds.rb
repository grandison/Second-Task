# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

require 'faker'

Rake::Task['db:reset'].invoke
99.times do |n|
  name  = Faker::Name.name
  login = "User#{n+1}"
  email = "example-#{n+1}@railstutorial.org"
  password  = "password"
  User.create!(:name => name,
                :login => login,
                :email => email,
                :password => password,
                :password_confirmation => password,
                :activated_at => Time.now.utc)
end
10.times do |n|
  name = Faker::Company.name
  Category.create!(:name => name)
end

99.times do |n|
  user_id = User.first.id
  category_id = 1+rand(10)
  topic = Faker::Lorem.paragraph
  text = Faker::Lorem.sentences
  tag_list = "tag, shmag, bag"
  rating = rand(1000)
  Post.create!(:user_id => user_id,
                  :category_id => category_id,
                  :topic => topic[0..250],
                  :text => text,
                  :tag_list => tag_list,
                  :rating => rating)
end

