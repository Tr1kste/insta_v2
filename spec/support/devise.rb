require "devise"

RSpec.configure do |config|
    config.include Devise::Test::ControllerHelpers, type: :view
    config.include Devise::Test::ControllerHelpers, type: :controller
    config.include Devise::Test::IntegrationHelpers, type: :feature
  
    # add these if you need other type of rspec.
    # config.include Devise::Test::IntegrationHelpers, type: :request
end