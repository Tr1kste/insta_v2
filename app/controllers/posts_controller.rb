# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy like unlike]

  def index
    @posts = Post.with_attached_image
                 .includes({ user: [avatar_attachment: :blob] }, [comments: :user])
                 .order(created_at: :desc)
                 .page params[:page]

    respond_to do |format|
      format.html
      format.js { render 'posts/paginate.js.erb' }
    end
  end

  def show; end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Ваш пост опубликован!'
      redirect_to root_path
    else
      flash.now[:alert] = 'Ваш новый пост не создан! Пожалуйста, проверьте форму.'
      render :new
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post

    if @post.update(post_params)
      flash[:success] = 'Пост обновлен.'
      redirect_to post_path(@post)
    else
      flash.now[:alert] = 'Ошибка обновления. Пожалуйста, проверьте форму.'
      render :edit
    end
  end

  def destroy
    authorize @post

    if @post.destroy
      flash[:success] = 'Пост удален.'
    else
      flash.now[:alert] = 'Ошибка удаления. Пожалуйста, попробуйте еще раз.'
    end
    redirect_to root_path
  end

  def like
    @post.liked_by current_user
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js
    end
  end

  def unlike
    @post.unliked_by current_user
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:description, :image, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
