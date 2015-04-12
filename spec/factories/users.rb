FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "123456789"
    password_confirmation "123456789"
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    birthdate Date.today.to_s
  end
end
