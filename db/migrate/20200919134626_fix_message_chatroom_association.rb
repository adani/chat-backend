class FixMessageChatroomAssociation < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :messages, :rooms

    change_table :messages do |t|
      t.remove :room_id
      t.references :chatrooms
    end
  end
end
