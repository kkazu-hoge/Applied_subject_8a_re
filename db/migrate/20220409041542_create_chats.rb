class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.integer :chat_room_id
      t.integer :from_user_id
      t.text :message
      t.timestamps
    end
  end
end
