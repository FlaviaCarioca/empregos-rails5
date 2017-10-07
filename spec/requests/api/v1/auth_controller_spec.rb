require 'rails_helper'

RSpec.describe API::V1::AuthController, type: :request do
  describe 'POST /v1/auth' do
    let(:user) { FactoryGirl.create(:user_candidate) }

    context 'user is authenticated with the correct credentials' do
      it 'generates a token' do
        post api_v1_auth_path, params: { auth: { username: user.email, password: user.password } }

        expect(response).to be_success
        expect(JSON.parse(response.body, symbolize_names: true)[:auth_token]).not_to be_nil
      end
    end

    context 'user cannot be authenticated due to incorrect credentials' do
      context 'wrong email' do
        it 'returns unauthorized error' do
          post api_v1_auth_path, params: { auth: { username: user.email + 'xyz', password: user.password } }

          expect(response).not_to be_success
          expect(response.status).to eq 401
        end
      end

      context 'wrong password' do
        it 'returns unauthorized error' do
          post api_v1_auth_path, params: { auth: { username: user.email, password: user.password + 'xyz' } }

          expect(response).not_to be_success
          expect(response.status).to eq 401
        end
      end
    end
  end
end
