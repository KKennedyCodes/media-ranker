require "test_helper"

describe UsersController do
  before do
    User.create!(name: "Jojo Siwa")
  end
  
  describe "current action" do
    it "sets session[:user_id], redirects, and responds with success" do
      
      perform_login
      
      get current_user_path
      
      must_respond_with :redirect
    end
    
    it "sets flash[:error] and redirects when there's no user" do
      get current_user_path
      
      expect(flash[:error]).must_equal "User with ID: current was not found."
      must_redirect_to root_path
    end
  end
  
  describe "auth_callback" do
    it "logs in an existing user and redirects to the root route" do
      # Count the users, to make sure we're not (for example) creating
      # a new user every time we get a login request
      start_count = User.count
      
      # Get a user from the fixtures
      user = users(:grace)
      
      # Tell OmniAuth to use this user's info when it sees
      # an auth callback from github
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))
      
      # Send a login request for that user
      # Note that we're using the named path for the callback, as defined
      # in the `as:` clause in `config/routes.rb`
      get auth_callback_path(:github)
      
      must_redirect_to root_path
      
      # Since we can read the session, check that the user ID was set as expected
      session[:user_id].must_equal user.id
      
      # Should *not* have created a new user
      User.count.must_equal start_count
    end
    
    it "creates an account for a new user and redirects to the root route" do
    end
    
    it "redirects to the login route if given invalid user data" do
    end
  end
end
