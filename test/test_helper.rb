ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/autorun'
require 'minitest/reporters'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  def setup
    OmniAuth.config_test_mode = true
  end
  
  def mock_auth_hash(user)
    return {
      provider: user.provider,
      uid: user.uid,
      info: {
        email: user.email,
        name: user.name
      }
    }
  end
  
  # Add more helper methods to be used by all tests here...
  def perform_login(user = nil)
    user ||= User.first
    
    login_data = {
      user: {
        name: user.name,
      },
    }
    
    post login_path, params: login_data
    
    expect(session[:user_id]).must_equal user.id
    
    return user
  end
  
  
  
end
