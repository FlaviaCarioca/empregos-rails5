require 'rails_helper'

RSpec.describe API::V1::UsersController, type: :request do
  describe 'POST Create' do
    before(:all) do
      @first_name = Faker::Name.first_name
      @last_name =  Faker::Name.last_name
      @email = Faker::Internet.email
      @password = Faker::Internet.password
      @type = Constants::CANDIDATE
    end

    it 'creates a candidate user' do
      post api_v1_users_path, params: {
                                          user: {
                                            first_name: @first_name,
                                            last_name: @last_name,
                                            email: @email,
                                            password: @password,
                                            user_type: @type
                                          }
                                      }

      expect(response).to be_success
    end

    it 'returns error if user candidate cannot be created' do
      allow(Candidate).to receive(:create).and_raise('error')
      post api_v1_users_path, params: {
                                          user: {
                                            first_name: @first_name,
                                            last_name: @last_name,
                                            email: @email,
                                            password: @password,
                                            user_type: @type
                                          }
                                      }
      expect(response).not_to be_success
      expect(response.status).to eq 422
    end
  end
end
