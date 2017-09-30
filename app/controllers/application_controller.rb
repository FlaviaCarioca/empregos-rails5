class ApplicationController < ActionController::API
  before_action :authenticate_request

  rescue_from JWT::ExpiredSignature do
    logger.info("ApplicationController - ExpiredSignature error")
    render json: { error: 'Auth token is expired' }, status: 419 # unofficial timeout status code
  end

  private

  # Find the user if able to decode the token.
  def authenticate_request
    if decoded_auth_token
      @current_user ||= User.find(decoded_auth_token[0]['user_id'])
    end

    if @current_user.blank?
      logger.info("ApplicationController#authenticate_request - Unauthorized Request")
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end

  def decoded_auth_token
    content = http_auth_header_content

    @decoded_auth_token ||= AuthToken.decode(content) if content

    @decoded_auth_token
  end

  # JWT's are stored in the Authorization header using this format:
  # Bearer somerandomstring.encoded-payload.anotherrandomstring
  def http_auth_header_content
    return @auth_header_content unless @auth_header_content.blank?

    if request.headers['Authorization'].present?
      @auth_header_content = request.headers['Authorization'].split(' ').last
    end

    @auth_header_content
  end
end
