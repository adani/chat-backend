module V1
  class SessionController < ApplicationController
    before_action :authenticate, except: :login

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
        response.set_cookie(:jwt, value: params[:token], path: '/')
        render json: google_user
      rescue GoogleIDToken::ValidationError => e
        render json: { error: e }
      end
    end

    def logout
      Rails.logger.debug("authenticated JWT: #{jwt}")
      if jwt == params[:id]
        redis.del("session:#{current_user.google_user_id}")
        response.delete_cookie :user_id
        response.delete_cookie :jwt
      else
        head :forbidden
      end
    end
  end
end