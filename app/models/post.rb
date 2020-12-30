class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comments
  has_many :users, through: :likes
  has_many :users, through: :comments

  validates_presence_of :title, :body

  def liked?(user)
    !!self.likes.find{|like| like.user_id == user.id}
  end
end
