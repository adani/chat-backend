class FixMessageChatroomAssociation3 < ActiveRecord::Migration[6.0]
  def change
    change_table :messages do |t|
      t.remove :chatrooms_id
    end
  end
end
