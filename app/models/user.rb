class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  attachment :profile_image

  validates :name, presence: true, uniqueness: true, length: {maximum:20, minimum:2}
  validates :introduction, length: {maximum:50}

  has_many :follower, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :follower, source: :followed
  has_many :followed, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :followed, source: :follower

 # has_many :follower, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
 #  has_many :followings, through: :follower, source: :follower
 #  has_many :followed, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
 #  has_many :followers, through: :followed, source: :followed

 #フォローする
  def follow(user_id)
   follower.create(followed_id: user_id)
  end
  # ユーザーのフォローを外す
  def unfollow(user_id)
   follower.find_by(followed_id: user_id).destroy

  end
  # フォロー確認をおこなう
  def following?(user)
   self.followings.include?(user)
  end
  
   def User.search(search, model, how)
       if model == "user"
         if how == "partical"
           User.where("name LIKE ?", "%#{search}%")
         elsif how == "forward"
           User.where("name LIKE ?", "#{search}%")
         elsif how == "backward"
           User.where("name LIKE?", "%#{search}")
         elsif how == "match"
           User.where("name LIKE?", "#{search}")
         end
       end
   end
end
