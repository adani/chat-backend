class RemovePasswordAddGoogleId < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.remove :password_digest
      t.string :google_user_id
      t.index :google_user_id
    end
  end
end
