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
  email = "example-#{n+1}@railstutorial.org"
  password  = "password"
  User.create!(:name => name,
                :email => email,
                :password => password,
                :password_confirmation => password)
end
10.times do |n|
  name = Faker::Company.name
  Category.create!(:name => name)
end

99.times do |n|
  user_id = 1+rand(99)
  category_id = 1+rand(10)
  topic = Faker::Lorem.paragraph
  text = Faker::Lorem.sentences
  source = Faker::Lorem.paragraphs
  tags = "test,test,test"
  rating = rand(1000)
  Post.create!(:user_id => user_id,
                  :category_id => category_id,
                  :topic => topic[0..254],
                  :text => text,
                  :source => source[0..254],
                  :tags => tags[0..254],
                  :rating => rating)
end

