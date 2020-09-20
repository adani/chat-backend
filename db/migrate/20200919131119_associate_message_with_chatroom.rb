class AssociateMessageWithChatroom < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :rooms, foreign_key: true
    add_index :messages, :room_id
  end
end
