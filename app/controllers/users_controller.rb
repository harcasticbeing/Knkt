class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    unless user_signed_in?
      redirect_to '/users/sign_in'
      return
    end
    id = params[:id]
    @user_view = User.find_by(id: id)
    @user = current_user
    puts "user id: #{@user.id}"
    puts "user_view id: #{@user_view.id}"
    @is_following = true
    relation = Following.where(user_id: @user.id).where(following_id: @user_view.id)
    puts relation
    @is_following = false if relation.blank?
    @posts = Post.where(user_id: id).limit(10)
  end

  def follow
    @user = current_user
    follow_user_id = follow_params.to_i
    @follow_user = User.find_by(id: follow_user_id)
    @following = Following.new(following_id: follow_user_id, user_id: @user.id)
    @follower = Follower.new(follower_id: @user.id, user_id: follow_user_id)
    @following.save
    @follower.save
    redirect_to action: 'show', id: follow_user_id
  end

  def unfollow
    @user = current_user
    follow_user_id = follow_params.to_i
    @follow_user = User.find_by(id: follow_user_id)
    @following = Following.where(following_id: follow_user_id).where(user_id: @user.id).first
    @follower = Follower.where(follower_id: @user.id).where(user_id: follow_user_id).first
    Following.destroy(@following.id)
    Follower.destroy(@follower.id)
    redirect_to action: 'show', id: follow_user_id
  end

  private
    def follow_params
      follow_param = params.require(:follow).permit(:user_id)
      follow_param[:user_id].to_i
    end
end