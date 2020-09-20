class FixMessageChatroomAssociation2 < ActiveRecord::Migration[6.0]
  def change
    change_table :messages do |t|
      t.remove :chatrooms
      t.references :chatroom
    end
  end
end
