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
end
