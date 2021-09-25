class Book < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true, length: {maximum:200}

  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def follower(user)
    favorites.where(user_id: user.id).exists?
  end

  def Book.search(search, model, how)
       if model == "book"
         if how == "partical"
           Book.where("title LIKE ?", "%#{search}%")
         elsif how == "forward"
           Book.where("title LIKE ?", "#{search}%")
         elsif how == "backward"
           Book.where("ti LIKE?", "%#{search}")
         elsif how == "match"
           Book.where(title: search)
         end
       end
   end

  # 本の投稿数を数えるため
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
end
