class ChatChannel < ApplicationCable::Channel
  def subscribed
    @room_id = params[:room_id]
    stream_from room_stream
    messages = Message.select('users.username as sender, messages.content, messages.created_at')
                      .joins(:chatroom, :user)
                      .where('chatrooms.id = ?', @room_id)
                      .last(10)
                      .as_json(except: :id)
    ActionCable.server.broadcast(room_stream, { type: 'initialize', payload: messages })
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    message = Message.create(user_id: current_user.id, chatroom_id: @room_id, content: data['content'])
    ActionCable.server.broadcast(room_stream, { type: 'new_chat', payload: { sender: current_user.username,
                                                                             content: message.content,
                                                                             created_at: message.created_at } })
  end

  private

  def room_stream
    "chat_room_#{params[:room_id]}"
  end
end
