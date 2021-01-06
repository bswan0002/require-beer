class Post < ApplicationRecord
  has_rich_text :content

  belongs_to :user
  has_many :likes
  has_many :comments
  has_many :users, through: :likes
  has_many :users, through: :comments

  validates_presence_of :title

  def liked?(user)
    !!self.likes.find{|like| like.user_id == user.id}
  end

  def self.title_asc
    Post.order('title ASC')
  end

  def self.title_desc
    Post.order('title DESC')
  end

  def self.author_asc
    Post.all.sort_by {|p| p.user.email}
  end

  def self.author_desc
    Post.all.sort_by {|p| p.user.email}.reverse
  end

  def self.published_asc
    Post.order('created_at ASC')
  end

  def self.published_desc
    Post.order('created_at DESC')
  end

  def self.likes_asc
    Post.all.sort_by {|p| p.likes.count}
  end

  def self.likes_desc
    Post.all.sort_by {|p| p.likes.count}.reverse
  end
  
end
