class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # フォロー機能
  has_many :relationships, foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :relationships, dependent: :destroy
  has_many :chats, foreign_key: "from_user_id"

  has_one_attached :profile_image


  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}


  # scope :today_post_books, ->{where(created_at: (1.days.ago)..(Time.now))}
  # scope :previous_post_books, ->{where(created_at: 1.day.ago.all_day)}
  # scope :thisweek_post_books, ->{where(created_at: (6.days.ago.beginning_of_day)..(Time.now))}
  # scope :lastweek_post_books, ->{where(created_at: (13.days.ago.beginning_of_day)..(1.week.ago.end_of_day))}


  #インスタンスメソッド
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def post_books_count
    #投稿数をハッシュに格納して返却するため、初期化
    post_books_cnt = {}
    # post_books_cnt = {"today_post": 0, "previous_post": 0, "thisweek_post": 0, "lastweek_post": 0}
    # post_books_cnt.clear
    #今日の投稿数(抽出条件はscopeで定義)
    post_books_cnt["today_post"] = self.books.where("created_at >= ?", Time.zone.now.beginning_of_day).count
    #前日の投稿数(抽出条件はscopeで定義)
    post_books_cnt["previous_post"] = self.books.where(created_at: 1.day.ago.all_day).count
    #今週の投稿数(抽出条件はscopeで定義)
    post_books_cnt["thisweek_post"] = self.books.where(created_at: (6.days.ago.beginning_of_day)..(Time.now)).count
    #先週の投稿数(抽出条件はscopeで定義)
    post_books_cnt["lastweek_post"] = self.books.where(created_at: (13.days.ago.beginning_of_day)..(1.week.ago.end_of_day)).count
    #前日比
    post_books_cnt["day_ratio"] = BigDecimal((post_books_cnt["previous_post"].to_f / post_books_cnt["today_post"].to_f).to_s).floor(2)*100
    #前週比
    post_books_cnt["week_ratio"] = BigDecimal((post_books_cnt["thisweek_post"].to_f / post_books_cnt["lastweek_post"].to_f).to_s).floor(2)*100

    return post_books_cnt

  end

end
