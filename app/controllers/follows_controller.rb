class FollowsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    def followers;end

    def followees;end

    private

    def set_user
        @user = User.find(params[:user_id])
    end
end
