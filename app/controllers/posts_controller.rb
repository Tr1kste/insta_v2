class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: %i[show edit update destroy like unlike]
    before_action :owned_post, only: %i[edit update destroy]

    def index
        @posts = Post.all.order(created_at: :desc)
    end
    
    def new
        @post = current_user.posts.build
    end

    def show
    end

    def create
        @post = current_user.posts.build(post_params)

        if @post.save
            flash[:success] = "Ваш пост опубликован!"
            redirect_to root_path
        else
            flash.now[:alert] = "Ваш новый пост не создан! Пожалуйста, проверьте форму."
            render :new
        end
    end

    def edit
    end

    def update
        @post.update(post_params)

        if @post.update(post_params)
          flash[:success] = "Пост обновлен."
          redirect_to post_path(@post)
        else
          flash.now[:alert] = "Ошибка обновления. Пожалуйста, проверьте форму."
          render :edit
        end
    end

    def destroy
        @post.destroy

        if @post.destroy
            flash[:success] = "Пост удален."
            redirect_back fallback_location: root_path
        else
            flash.now[:alert] = "Ошибка удаления. Пожалуйста, попробуйте еще раз."
            redirect_back fallback_location: root_path
        end
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

    def owned_post
        unless current_user == @post.user
            flash[:alert] = "Недостаточно прав для данного действия!"
            redirect_back fallback_location: root_path
        end
    end
end
