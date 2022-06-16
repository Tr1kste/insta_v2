class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, except: %i[index]

    def index
        @users = User.order(:name)
    end

    def show
    end

    def edit
    end

    def update
        @user.update(user_params)
        redirect_to current_user
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
