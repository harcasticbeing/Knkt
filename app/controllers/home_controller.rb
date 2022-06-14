class HomeController < ApplicationController
  def index
    @user = current_user
    @posts = Post.order(created_at: :desc).last(10)
  end
  
  def followers
    @user = current_user
    @follower_records = Follower.where(user_id: @user.id)
    @followers = []
    @follower_records.each do |fr|
      f = User.find_by(id: fr.follower_id)
      @followers.append(f)
    end
  end
  
  def followings
    @user = current_user
    @followings_records = Following.where(user_id: @user.id)
    @followings = []
    @followings_records.each do |fr|
      f = User.find_by(id: fr.following_id)
      @followings.append(f)
    end
  end
end
