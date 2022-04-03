class UsersController < ApplicationController
  include Common
  before_action :set_search_window
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    #ページネーション追加#
    @books = @user.books.page(params[:page])
    @book = Book.new
    #投稿数関連のデータ取得#
    @post_books_cnt = User.find(params[:id]).post_books_count
    #7日間分の投稿数に関するインスタンス変数#
    @today_post_count = @user.books.today_post_books
    @previous_post_count = @user.books.previous_post_books
    @ago2_post_count = @user.books.ago2_post_books
    @ago3_post_count = @user.books.ago3_post_books
    @ago4_post_count = @user.books.ago4_post_books
    @ago5_post_count = @user.books.ago5_post_books
    @ago6_post_count = @user.books.ago6_post_books
     #投稿グラフ表示用の配列
    @graph_label = [ '6日前','5日前','4日前','3日前','2日前','1日前','今日']
    @graph_prot_count = [
        @ago6_post_count,
        @ago5_post_count,
        @ago4_post_count,
        @ago3_post_count,
        @ago2_post_count,
        @previous_post_count,
        @today_post_count
      ]
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :title)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
