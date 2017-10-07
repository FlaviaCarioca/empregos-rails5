require 'rails_helper'

describe ApplicationController, type: :controller do
  # Create a dummy method to test the before action
  controller do
    def dummy
      render :head
    end
  end
  # In order to use custom routes within an anonymous controller spec we need to amend the route set
  # in a before block.
  before do
    @routes.draw do
      get '/anonymous/dummy'
    end
  end

  describe '#authenticate_request' do
    it 'authenticates a request with authorization header' do
      user = FactoryGirl.build_stubbed(:user_candidate)
      decoded_token = [{ 'user_id'=> user.id, 'exp'=>1437839090 }, { 'typ'=>'JWT', 'alg'=>'HS256' }]
      allow(controller).to receive(:decoded_auth_token).and_return(decoded_token)
      controller.instance_variable_set(:@current_user, user)

      get :dummy

      expect(assigns(:current_user)).to eq user
    end

    it 'does not authenticates a request with authorization header' do
      allow(controller).to receive(:decoded_auth_token).and_return(nil)

      get :dummy

      expect(response.status).to eq 401
      expect(assigns(:current_user)).to be_nil
    end

    it 'returns expired token error when token is expired' do
      expired_encoded_token = expired_token_generator(FactoryGirl.create(:user_candidate).id)
        # expired_encoded_token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3LCJleHAiOjE0Mzc1ODQ2NDN9.ocJBlWM5QN3rWiZEwL_rm1LsXbptAcBRNy9jhSG_6XY'
        controller.instance_variable_set(:@auth_header_content, expired_encoded_token)

        get :dummy

        expect(response).not_to be_success
        expect(response.status).to eq 419
    end
  end

  describe '#decoded_auth_token' do
    it 'decodes an auth token' do
      user = FactoryGirl.create(:user_candidate)
      encoded_token = token_generator(user.id)

      controller.instance_variable_set(:@auth_header_content, encoded_token)

      decoded_token = controller.send(:decoded_auth_token)

      expect(decoded_token).not_to be_nil
      expect(decoded_token['user_id']).to eq user.id
    end

    it 'returns nil if there is no auth token' do
      encoded_token = nil

      controller.instance_variable_set(:@auth_header_content, encoded_token)

      decoded_token = controller.send(:decoded_auth_token)

      expect(decoded_token).to be_nil
    end
  end

  describe '#http_auth_header_content' do
    it 'returns the authorization headers if it exists' do
      request = double('request')
      headers = double('headers')
      bearer_string = 'Bearer somerandomstring.encoded-payload.anotherrandomstring'
      encoded_token = 'somerandomstring.encoded-payload.anotherrandomstring'

      allow(controller).to receive(:request).and_return(request)
      allow(request).to receive(:headers).and_return(headers)
      allow(headers).to receive(:[]).with('Authorization').and_return(bearer_string)

      expect(controller.send(:http_auth_header_content)).to eq encoded_token
    end

    it 'returns the authorization token if @http_auth_header_content has been populated' do
      encoded_token = 'somerandomstring.encoded-payload.anotherrandomstring'

      controller.instance_variable_set(:@auth_header_content, encoded_token)

      expect(controller.send(:http_auth_header_content)).to eq encoded_token
    end
  end
end
