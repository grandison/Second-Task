Factory.define :user do |user|
  user.login                     "quentin"
  user.name                      "quentin"
  user.email                     "quentin@example.com"
  user.salt                      "356a192b7913b04c54574d18c28d46e6395428ab" # SHA1('0')
  user.crypted_password          "a303b2e109f41d84dc7531186cd539fdb971be43" # 'monkey'
  user.created_at                "#{5.days.ago.to_s}"
  user.remember_token_expires_at "#{1.days.from_now.to_s}"
  user.remember_token            "77de68daecd823babbb58edb1c8e14d7106e83bb"
  user.activation_code
  user.activated_at              "#{5.days.ago.to_s}"
end
Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
Factory.define :category do |cat|
  cat.name "interesting things"
end

