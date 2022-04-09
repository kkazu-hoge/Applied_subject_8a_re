class Chat < ApplicationRecord
   has_many :relationships, foreign_key: "chat_room_id"
   has_many :chats, foreign_key: "chat_room_id"
end
