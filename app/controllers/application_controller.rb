class ApplicationController < ActionController::Base
     include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
        redirect_back fallback_location: root_path
        flash[:alert] = 'Недостаточно прав для данного действия!'
    end
end
