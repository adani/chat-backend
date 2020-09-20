module V1
  class SessionController < ApplicationController
    require 'google-id-token'
    require 'redis'

    def login
      validator = GoogleIDToken::Validator.new
      aud = Rails.configuration.google['client-id']
      begin
        google_user = validator.check(params[:token], aud)
        unless (user = User.find_by(google_user_id: google_user['sub']))
          user = User.create(username: google_user['name'], google_user_id: google_user['sub'])
        end
        redis.set("session:#{google_user['sub']}", params[:token])
        response.set_cookie(:user_id, value: user.id, path: '/')
        render json: google_user
      rescue GoogleIDToken::ValidationError => e
        render json: { error: e }
      end
    end

    def logout
    end

    def refresh
    end

    private

    def redis
      Redis.current
    end
  end
end