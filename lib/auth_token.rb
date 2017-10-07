module AuthToken

  def self.encode(payload, exp: 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, ENV['API_SECRET'])
  rescue StandardError => ex
    Rails.logger.error("AuthToken.encode: #{ex}")
    nil # If anything goes wrong return nil
  end

  def self.decode(token)
    HashWithIndifferentAccess.new(JWT.decode(token, ENV['API_SECRET'], true, algorithm: 'HS256')[0])
  rescue JWT::ExpiredSignature, JWT::VerificationError => ex
    raise JWT::ExpiredSignature # this will be handled in the application controller
  rescue StandardError => ex
    Rails.logger.error("AuthToken.decode: #{ex}")
    nil # If anything goes wrong return nil
  end
end