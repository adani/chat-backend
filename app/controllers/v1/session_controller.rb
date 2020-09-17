module V1
  class SessionController < ApplicationController
    require 'google-id-token'

    def login
      validator = GoogleIDToken::Validator.new
      aud = Rails.configuration.google['client-id']
      logger.debug { "Audience: #{aud}" }
      begin
        payload = validator.check(params[:token], aud)
        render json: payload
      rescue GoogleIDToken::ValidationError => e
        render json: { error: e }
      end
    end

    def logout
    end

    def refresh
    end
  end
end