class AddChatRoomIdToRelationships < ActiveRecord::Migration[6.1]
  def change
    add_column :relationships, :chat_room_id, :integer
  end
end
