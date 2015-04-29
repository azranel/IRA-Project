# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  firstname              :string
#  lastname               :string
#  birthdate              :date
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  auth_token             :string           default("")
#

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
