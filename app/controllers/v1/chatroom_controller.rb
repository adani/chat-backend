module V1
  class ChatroomController < ApplicationController
    before_action :authenticate

    require 'base64'
    require 'uri'

    def get_online_users
      pubsub = ActionCable.server.pubsub
      redis_conn = pubsub.send(:redis_connection)
      open_connections = redis_conn.pubsub('channels', pubsub.send(:channel_with_prefix, "action_cable/*"))

      online_users = []
      open_connections.each do |connection|
        uri = URI.parse(Base64.decode64(connection.split('/')[1]))
        paths = uri.path.split('/')
        if paths[1] == 'User'
          online_users.push(User.select(:id, :username).find(paths[2]))
        end
      end

      Rails.logger.debug(online_users)
      render json: { users: online_users }
    end
  end
end
