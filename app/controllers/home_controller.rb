# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.with_attached_image.includes({ user: [avatar_attachment: :blob]}, [comments: :user]).of_followed_users(current_user.followees).or(Post.of_current_user(current_user)).order(created_at: :desc)
    @users = User.all
  end
end
