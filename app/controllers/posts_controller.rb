class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @user = current_user
    @posts = Post.where(user_id: @user.id)
  end

  def show
    @user = current_user
    @post = Post.find_by(id: params[:id])
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
