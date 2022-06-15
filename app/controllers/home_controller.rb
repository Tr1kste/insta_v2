class HomeController < ApplicationController
  def index
    redirect_to new_user_session_path unless user_signed_in?

    @posts = Post.order(created_at: :desc)
  end
end
