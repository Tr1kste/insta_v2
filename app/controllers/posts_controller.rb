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
            flash[:success] = "Your post has been created!"
        else
            flash.now[:alert] = "Your new post couldn't be created! Please check the form."
            render :new
        end
    end

    private

    def post_params
        params.require(:post).permit(:description, :image, :user_id)
    end

end
