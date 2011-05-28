Factory.define :user do |user|
  user.name                  "Michael Hartl"
  user.email                 "mhartl_test@example.com"
  user.password              "foobar_test"
  user.password_confirmation "foobar_test"
end
Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

