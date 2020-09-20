class AssociateMessageWithUser < ActiveRecord::Migration[6.0]
  def change
    change_table :messages do |t|
      t.references :user
    end
  end
end
