class HomeController < ApplicationController
  before_action :authenticate_user!

  def index   
    @posts = Post.order(created_at: :desc)
    @users = User.order(:name)
  end

end
