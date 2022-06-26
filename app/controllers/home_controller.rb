class HomeController < ApplicationController
  before_action :authenticate_user!

  def index   
    @posts = Post.of_followed_users(current_user.followees).order(created_at: :desc)
    @users = User.order(:name)
  end

end
