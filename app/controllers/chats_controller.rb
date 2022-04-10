class ChatsController < ApplicationController
  include Common
  before_action :set_search_window
  before_action :verifi_datauser_loginuser_mdlbook, only: [:edit, :update]


  def index
    @to_user = User.find(params[:user_id])
    @from_user = User.find(params[:from_user_id])
    follower = Follower.find_by(user_id: @from_user.id)
    chat_room_id = Relationship.find_by(follower_id: follower.id, followed_id: @to_user.id).chat_room_id
    @chat_index = Chat.where(chat_room_id: chat_room_id)
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_message_params)
    @chat.from_user_id = params[:from_user_id]
    chat_room_id = Relationship.find_by(follower_id: @chat.from_user_id, followed_id: params[:user_id]).chat_room_id
    @chat.chat_room_id = chat_room_id
    if @chat.save
      redirect_to request.referer, notice: "Event was successfully created."
    else
      #render時に必要なインスタンス変数を再度取得(@chatは入力値を残したまま)
      @to_user = User.find(params[:user_id])
      @from_user = User.find(params[:from_user_id])
      follower = Follower.find_by(user_id: @from_user.id)
      chat_room_id = Relationship.find_by(follower_id: follower.id, followed_id: @to_user.id).chat_room_id
      @chat_index = Chat.where(chat_room_id: chat_room_id)

      render :index
    end
  end

  private
  def chat_message_params
    params.require(:chat).permit(:message)
  end

end
