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

  # scope :books_favorite_sort, ->{left_joins(:favorites).select('books.*, count(favorites.book_id) as fav_count').group(:book_id).order(Arel.sql('fav_count desc'))}
  #クラスメソッド#

  def self.date_post_books_count(search_date)
    count_result =  Book.where(created_at: search_date.in_time_zone.all_day).count
    return count_result
  end

  # def self.sort_books_favorite_desc
  #   result = ActiveRecord::Base.connection.select_all('select b.*, f.cnt from books b left outer join (select book_id, count(book_id) as cnt from favorites group by book_id) f on b.id = f.book_id order by f.cnt desc')
  #   return result.to_a
  # end


  # def self.sort_books_favorite_desc_user(user_id)
  #   result = ActiveRecord::Base.connection.select_all('select b.*, f.cnt from books b left outer join (select book_id, count(book_id) as cnt from favorites group by book_id) f on b.id = f.book_id where b.user_id = #{user_id} order by f.cnt desc')
  #   return result.to_a
  # end

  def self.sort_books_favorite_desc(*args)
    if args.length == 0
      result = ActiveRecord::Base.connection.select_all('select b.*, f.cnt from books b left outer join (select book_id, count(book_id) as cnt from favorites group by book_id) f on b.id = f.book_id order by f.cnt desc')
    elsif args.length == 1
      #プレースホルダー
      sql = ActiveRecord::Base.sanitize_sql_array(['select b.*, f.cnt from books b left outer join (select book_id, count(book_id) as cnt from favorites group by book_id) f on b.id = f.book_id where b.user_id = (:user_id) order by f.cnt desc', user_id: args[0]])
      #生SQL実行
      result = ActiveRecord::Base.connection.select_all(sql)
      # result = ActiveRecord::Base.connection.select_all('select b.*, f.cnt from books b left outer join (select book_id, count(book_id) as cnt from favorites group by book_id) f on b.id = f.book_id where b.user_id = "#{args[0]}" order by f.cnt desc')
      # binding.pry
    else
      result = 0
    end
    return result.to_a
  end

  #インスタンスメソッド#

end
