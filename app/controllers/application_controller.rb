class ApplicationController < ActionController::API
  attr_reader :current_user, :jwt
  require 'jwt'

  def authenticate
    validator = GoogleIDToken::Validator.new
    aud = Rails.configuration.google['client-id']
    begin
      jwt = request.cookie_jar[:jwt]
      google_user = validator.check(jwt, aud)
      stored_token = redis.get("session:#{google_user['sub']}")

      if stored_token == jwt
        @current_user = User.find_by(google_user_id: google_user['sub'])
        @jwt = jwt
      else
        head :unauthorized
      end
    rescue GoogleIDToken::ValidationError => e
      head :unauthorized
    end
  end

  def redis
    Redis.current
  end
end
