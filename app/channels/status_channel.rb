class StatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from room_status_channel
  end

  def unsubscribed
    ActionCable.server.broadcast(room_status_channel,
                                 { type: 'offline', user: { id: current_user.id, username: current_user.username } })
  end

  def online
    ActionCable.server.broadcast(room_status_channel,
                                 { type: 'online', user: { id: current_user.id, username: current_user.username } })
  end

  private

  def room_status_channel
    "status_channel_room_#{params[:room_id]}"
  end
end
