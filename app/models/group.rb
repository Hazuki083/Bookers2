class Group < ApplicationRecord

  attachment :image_id

  has_many :group_users
  has_many :users, through: :group_users
  validates :name, presence: true, uniqueness: true

end
