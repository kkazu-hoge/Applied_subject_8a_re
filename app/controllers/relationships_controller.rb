class RelationshipsController < ApplicationController
  include Common
  before_action :set_search_window

  def create
    user = User.find(params[:follower_id]) #current_user
    followed_user = User.find(params[:user_id])
    #followersテーブルにcurrent_userのfollowerとしてのデータがなければfollowersテーブルに新規登録する
    unless Follower.exists?(user_id: user.id)
      follower = Follower.new(user_id: user.id, user_name: user.name)
      follower.save
    end

    #followed_userのfollowerグループにfollower_userを追加する
    follower_user = Follower.find_by(user_id: user.id)
    if followed_user.followers << follower_user
      if Relationship.where(followed_id: user.id, follower_id: followed_user.id).exists?
        #自分がフォローしたuserがフォロワーとしても存在しているなら、chatroomが作成されているので、そのidを自分がfollwerとしてのrelationshipレコードに登録する
        chat_room_id = Relationship.find_by(followed_id: user.id, follower_id: followed_user.id).chat_room_id
        relationship = Relationship.find_by(followed_id: followed_user.id, follower_id: user.id)
        relationship.update(chat_room_id: chat_room_id)
      else
        #自分がフォローしたuserがフォロワーとしても存在しない場合、chatroomを新規作成し、そのidを自分がfollwerとしてのrelationshipレコードに登録する
        chat_room = ChatRoom.new(name: user.name+"-"+followed_user.name)
        chat_room.save
        relationship = Relationship.find_by(followed_id: followed_user.id, follower_id: user.id)
        relationship.update(chat_room_id: chat_room.id)
      end
      #request.refererで遷移前のURLを保持している
      redirect_to request.referer
    else
      @users = User.all
      @book = Book.new
      render 'users/index'
    end
  end

  def destroy
    # binding.pry
    relationship = Relationship.find(params[:id])
    relationship.destroy
    redirect_to request.referer
  end

  def follow_index
    #
    if Follower.exists?(user_id: params[:user_id])
      @follows = Follower.find_by(user_id: params[:user_id]).users
    else
      @follows = ""
    end
  end

  def follower_index
    #userは必ず存在するのでレコードありなしの判定は不要
    @followers = User.find(params[:user_id]).followers
  end

  private
  # def relationship_params
  #   params.require(:relationship).permit(:chat_room_id)
  # end

end
