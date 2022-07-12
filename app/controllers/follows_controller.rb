# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def followers
    @followers = @user.followers.with_attached_avatar
  end

  def followees
    @followees = @user.followees.with_attached_avatar
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
