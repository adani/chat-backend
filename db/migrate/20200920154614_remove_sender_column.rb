class RemoveSenderColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :messages, :sender
  end
end
