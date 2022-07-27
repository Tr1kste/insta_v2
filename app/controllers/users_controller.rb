# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @posts = Post.with_attached_image.includes(:user).order(created_at: :desc)
    @posts_with_comments = Post.includes([comments: :user])
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    if @user.update(user_params)
      flash[:success] = 'Данные обновлены.'
      redirect_to current_user
    else
      flash.now[:alert] = 'Ошибка заполнения. Пожалуйста, проверьте форму.'
      render :edit
    end
  end

  def follow
    if current_user != @user && (current_user.followees << @user)
      respond_to do |format|
        format.html { redirect_to user_path(@user) }
        format.js
      end
    end
  end

  def unfollow
    if current_user.followed_users.find_by(followee_id: @user.id).destroy
      respond_to do |format|
        format.html { redirect_to user_path(@user) }
        format.js
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :website,
                                 :bio, :email, :phone, :gender, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
