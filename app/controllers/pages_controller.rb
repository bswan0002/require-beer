class PagesController < ApplicationController
  def home
    @featured_post = Post.most_liked
    @featured_project = Project.most_recent
  end
end
