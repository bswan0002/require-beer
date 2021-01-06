class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :authenticate_user!, except: [:show, :index, :sort_by_col]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    Like.create(user_id: current_user.id, post_id: @post.id)
    redirect_to post_path(@post)
  end

  def unlike
    @like = Like.find_by(user_id: current_user.id, post_id: params[:id])
    @like.destroy
    redirect_to post_path(@post)
  end

  def sort_by_col
    case params[:c]
    when "title_asc"
      @posts = Post.order('title ASC')
    when "title_desc"
      @posts = Post.order('title DESC')
    when "author_asc"
      @posts = Post.all.sort_by {|p| p.user.email}
    when "author_desc"
      @posts = Post.all.sort_by {|p| p.user.email}.reverse
    when "published_asc"
      @posts = Post.order('created_at ASC')
    when "published_desc"
      @posts = Post.order('created_at DESC')
    when "likes_desc"
      @posts = Post.all.sort_by {|p| p.likes.count}.reverse
    when "likes_asc"
      @posts = Post.all.sort_by {|p| p.likes.count}
    end

    @sort = params[:c]
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id)
    end
end
