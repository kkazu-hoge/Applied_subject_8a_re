class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence:true
  validates :body, presence:true,length:{maximum:200}
  
  scope :today_post_books, ->{where("created_at >= ?", Time.zone.now.beginning_of_day).count}
  scope :previous_post_books, ->{where(created_at: 1.day.ago.all_day).count}
  scope :ago2_post_books, ->{where(created_at: 2.day.ago.all_day).count}
  scope :ago3_post_books, ->{where(created_at: 3.day.ago.all_day).count}
  scope :ago4_post_books, ->{where(created_at: 4.day.ago.all_day).count}
  scope :ago5_post_books, ->{where(created_at: 5.day.ago.all_day).count}
  scope :ago6_post_books, ->{where(created_at: 6.day.ago.all_day).count}
  
end
