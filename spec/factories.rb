Factory.define :user do |user|
  user.sequence(:login)      {|n| "MichaelHartl#{n}"}
  user.name                  "MichaelHartl"
  user.sequence(:email)      {|n| "mhartl_test#{n}@example.com"}
  user.password              "foobar_test"
  user.password_confirmation "foobar_test"
  user.activated_at          Time.now.utc
end
Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
Factory.define :post do |post|
    post.content "Foo bar"
    post.association :user
end

