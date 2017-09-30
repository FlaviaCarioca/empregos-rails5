require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to(:profile) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:profile_id) }
  it { should validate_presence_of(:profile_type) }

  it { should validate_length_of(:email).is_at_most(50) }
  it { should validate_length_of(:password).is_at_most(50) }
  it { should validate_length_of(:profile_type).is_at_most(10) }

  describe 'uniqueness' do
    # This matcher works a bit differently than other matchers.
    # It will create an instance of your model if one doesn't already exist.
    # Sometimes this step fails, especially if you have database-level restrictions on any
    # attributes other than the one which is unique. In this case, the solution is to populate these
    # attributes with before you call validate_uniqueness_of.
    subject { FactoryGirl.build(:user_candidate) }
    it { should validate_uniqueness_of(:profile_id).scoped_to(:profile_type) }
  end

  it 'has a valid factory for candidates' do
    expect(FactoryGirl.build_stubbed(:user_candidate)).to be_valid
  end

  it 'finds a user with correct credentials' do
    user = FactoryGirl.create(:user_candidate)

    fetched_user = User.find_by_credentials(user.email, user.password)

    expect(fetched_user.id).to eq user.id
  end

  it 'does not find a user if incorrect username is passed' do
    user = FactoryGirl.create(:user_candidate)

    fetched_user = User.find_by_credentials(Faker::Internet.email, user.password)

    expect(fetched_user).to be_nil
  end

  it 'does not find a user if incorrect password is passed' do
    user = FactoryGirl.create(:user_candidate)

    fetched_user = User.find_by_credentials(user.email, user.password + 'xyz')

    expect(fetched_user).to be_nil
  end

  it 'genereates a token if a user has correct credentials' do
    user = FactoryGirl.create(:user_candidate)

    fetched_user = User.find_by_credentials(user.email, user.password)

    token = fetched_user.generate_auth_token

    expect(token).not_to be_nil
  end
end
