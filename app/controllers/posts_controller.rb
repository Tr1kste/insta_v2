class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: %i[index]
    before_action :set_post, only: %i[show edit update destroy]

    def index
        @posts = @user.posts.order(created_at: :desc)
    end
    
    def new
        @post = current_user.posts.build
    end

    def show
    end

    def create
        @post = current_user.posts.build(post_params)

        if @post.save
            flash[:success] = "Your post has been created!"
            redirect_to root_path
        else
            flash.now[:alert] = "Your new post couldn't be created! Please check the form."
            render :new
        end
    end

    def edit
    end

    def update
        @post.update(post_params)

        if @post.update(post_params)
          flash[:success] = "Post updated."
          redirect_to post_path(@post)
        else
          flash.now[:alert] = "Update failed. Please check the form."
          render :edit
        end
    end

    def destroy
        @post.destroy
        redirect_to user_path(current_user)
    end

    private

    def post_params
        params.require(:post).permit(:description, :image, :user_id)
    end

    def set_user
        @user = User.find(params[id])
    end

    def set_post
        @post = Post.find(params[:id])
    end
end
