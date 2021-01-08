class Post < ApplicationRecord
  has_rich_text :content

  belongs_to :user
  has_many :likes, :dependent => :delete_all
  has_many :comments, :dependent => :delete_all
  has_many :users, through: :likes
  has_many :users, through: :comments

  validates_presence_of :title

  def liked?(user)
    !!self.likes.find{|like| like.user_id == user.id}
  end

  def preview
    special = "?<>',?[]}{=-)(*&^%$#`~{}"
    regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/

    prev = self.content.to_plain_text.split(" ").first(12)

    if prev.last && prev.last[-1].match(regex)
      prev.last.chop!
      return prev.join(" ") + "..."
    elsif prev.last && prev.length > 4
      return prev.join(" ") + "..."
    else
      return "Preview not available"
    end
  end

  def like_count
    self.likes.count
  end

  def self.most_liked
    Post.all.max_by{|p| p.like_count}
  end


  def published
    self.created_at.strftime("%b. %d %Y")
  end

  def self.last_row
    post_count = Post.all.count
    return 0 if post_count < 3
    case post_count%3
    when 0
      return 3
    when 1
      return 1
    when 2
      return 2
    end
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

  #I recognize method name and activerecord sort don't match,
  #but I want first click w/ up arrow sorting newest to oldest
  def self.published_asc
    Post.order('created_at DESC')
  end

  def self.published_desc
    Post.order('created_at ASC')
  end

  def self.likes_asc
    Post.all.sort_by {|p| p.likes.count}.reverse
  end

  def self.likes_desc
    Post.all.sort_by {|p| p.likes.count}
  end

  def self.my_liked_posts(this_user)
    this_user.likes.map {|like| like.post}
  end

  #comment to like ratio[admin only], if high might indicate
  #inflammatory/incorrect content
  def ctlr
    self.likes.count == 0 ? likes = 1 : likes = self.likes.count
    return self.comments.count / likes
  end

end
