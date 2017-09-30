require 'faker'

FactoryGirl.define do
  factory :candidate do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    description { Faker::Lorem.sentence(5) }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.postcode[0..4] }
    title 'Software Engineer'
    minimum_salary '180000'
    linkedin { Faker::Internet.user_name }
    github { Faker::Internet.user_name }
    is_active true
    can_relocate false
    can_remote true
    is_visa_needed true
    created_at DateTime.now
    updated_at DateTime.now
  end
end
