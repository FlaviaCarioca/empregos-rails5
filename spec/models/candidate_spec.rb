require 'rails_helper'

RSpec.describe Candidate, type: :model do
  it { should have_one(:user) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  it { should validate_length_of(:first_name).is_at_most(50) }
  it { should validate_length_of(:last_name).is_at_most(70) }
  it { should validate_length_of(:address).is_at_most(100) }
  it { should validate_length_of(:title).is_at_most(100) }
  it { should validate_length_of(:city).is_at_most(50) }
  it { should validate_length_of(:state).is_at_most(2) }
  it { should validate_length_of(:zip).is_equal_to(5) }
  it { should validate_length_of(:description).is_at_most(250) }
  it { should validate_length_of(:minimum_salary).is_at_most(8) }
  it { should validate_length_of(:linkedin).is_at_most(50) }
  it { should validate_length_of(:github).is_at_most(50) }

  it 'has a valid factory for candidates' do
    expect(FactoryGirl.build_stubbed(:candidate)).to be_valid
  end
end
