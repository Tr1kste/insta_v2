class UserPolicy
    attr_reader :user, :current_profile
  
    def initialize(user, current_profile)
      @current_user = user
      @current_profile = current_profile
    end
  
    def edit?
        update?
    end
  
    def update?
        @current_user == @current_profile
    end
end