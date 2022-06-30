class FollowsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    def followers
        @followers = @user.followers
    end

    def followees
        @followees = @user.followees
    end

    private

    def set_user
        @user = User.find(params[:user_id])
    end
end
