require 'jwt'

module AuthenticationHelper
  def auth_headers(user_id)
    { 'Authorization':  token_generator(user_id) } 
  end

  def token_generator(user_id)
    JWT.encode({ user_id: user_id }, ENV['API_SECRET'])
  end

  # generate expired tokens from user id
  def expired_token_generator(user_id)
    payload = { 
                user_id: user_id,
                exp: Time.now.to_i - 10
              }
    JWT.encode(payload, ENV['API_SECRET'])
  end
end