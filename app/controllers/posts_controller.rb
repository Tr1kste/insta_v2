class PostsController < ApplicationController
    def index
        @posts = Post.all
    end
    
    def new
    end

    def show
        @post = Post.find(params[:id])
    end

    def create
        if @post = Post.create(post_params)
            redirect_to root_path
        else
            render :new
        end
    end

    private

    def post_params
        params.require(:post).permit(:description, :image, :user_id)
    end

end
