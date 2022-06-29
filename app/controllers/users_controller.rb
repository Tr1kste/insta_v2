class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, except: %i[index]
    before_action :owned_post, only: %i[edit update]

    def index
        @users = User.order(:name)
    end

    def show
    end

    def edit
    end

    def update
        if @user.update(user_params)
            flash[:success] = "Данные обновлены."
            redirect_to current_user
        else
            flash.now[:alert] = "Ошибка заполнения. Пожалуйста, проверьте форму."
            render :edit
        end
    end

    def follow
        if current_user.followees << @user
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

    def owned_post
        unless current_user == @user
            flash[:alert] = "Недостаточно прав для данного действия!"
            redirect_back fallback_location: root_path
        end
    end
end
