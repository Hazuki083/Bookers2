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
end
