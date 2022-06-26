class HomeController < ApplicationController
  before_action :authenticate_user!

  def index   
    @posts = Post.of_followed_users(current_user.followees).or(Post.of_current_user(current_user)).order(created_at: :desc)
    @users = User.order(:name)
  end

end
