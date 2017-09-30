require 'rails_helper'

RSpec.describe API::V1::AuthController, type: :controller do
  describe 'POST #authenticate' do
    let(:user) { FactoryGirl.build_stubbed(:user_candidate) }

    context 'user is authenticated with the correct credentials' do
      it 'generates a token' do
        allow(User).to receive(:find_by_credentials).with(user.email, user.password).and_return(user)

        post :authenticate, params: { auth: { username: user.email, password: user.password } }

        expect(response).to be_success
        expect(JSON.parse(response.body, symbolize_names: true)[:auth_token]).not_to be_nil
      end

      it 'raises error if it cannot generate token' do
        @user_relation = double('user_relation')
        allow(User).to receive(:find_by_credentials).with(user.email, user.password).and_return(user)
        allow(user).to receive(:generate_auth_token).and_return(nil)

        post :authenticate, params: { auth: { username: user.email, password: user.password } }

        expect(response).not_to be_success
        expect(response.status).to eq 500
      end
    end

    context 'user cannot be authenticated due to incorrect credentials' do
      it 'returns unauthorized error' do
        allow(User).to receive(:find_by_credentials).with(user.email, user.password).and_return(nil)

        post :authenticate, params: { auth: { username: user.email, password: user.password } }

        expect(response).not_to be_success
        expect(response.status).to eq 401
      end
    end
  end
end
