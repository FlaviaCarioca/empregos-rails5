module AuthToken
  def self.encode(payload, exp: 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, ENV['API_SECRET'])
  rescue StandardError => ex
    Rails.logger.error("AuthToken.encode: #{ex}")
    nil # If anything goes wrong return nil
  end

  def self.decode(token)
    JWT.decode(token, ENV['API_SECRET'], true, algorithm: 'HS256')
  end
end
