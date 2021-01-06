class DevsController < ApplicationController

  def index
    @users = User.select{ |x| x.admin == true}
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.select{ |x| x.user_id == @user.id}
  end



end
