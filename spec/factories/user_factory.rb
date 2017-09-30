require 'faker'

FactoryGirl.define do
  factory :user_candidate, class: 'User' do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    created_at DateTime.now
    updated_at DateTime.now
    association :profile, factory: :candidate
  end
end
