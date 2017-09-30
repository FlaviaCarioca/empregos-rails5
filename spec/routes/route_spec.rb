require 'rails_helper'

RSpec.describe 'api routing', :type => :routing do
  it 'routes /v1/auth to auth#authenticate' do
    expect(post: '/v1/auth').to route_to(
      controller: 'api/v1/auth',
      action: 'authenticate',
      format: 'json'
    )
  end

  it 'routes /v1/users to users#create' do
    expect(post: '/v1/users').to route_to(
      controller: 'api/v1/users',
      action: 'create',
      format: 'json'
    )
  end
end