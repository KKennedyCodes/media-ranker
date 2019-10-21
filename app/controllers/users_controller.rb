class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :user_not_found, only: [:show, :edit]#, :destroy]
  
  
  def index
    @users = User.all
  end
  
  def show; end
  
  def login_form
    @user = User.new
  end
  
  def login
    name = params[:user][:name]
    user = User.find_by(name: name)
    
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{name}"
    else
      user = User.create(name: name, join_date: Time.now)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{user.name}"
    end
    
    redirect_to root_path
  end
  
  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out!"
    
    redirect_to root_path
  end
  
  def new
    @user = User.new
  end
  
  def create
    auth_hash = request.env["omniauth.auth"]
    
    user = User.find_by(uid: auth_hash[:uid], provider: "github")
    if user
      # User was found in the database
      flash[:success] = "Logged in as returning user #{user.name}"
    else
      # User doesn't match anything in the DB
      # Attempt to create a new user
      user = User.build_from_github(auth_hash)
      
      if user.save
        flash[:success] = "Logged in as new user #{user.name}"
      else
        # Couldn't save the user for some reason. If we
        # hit this it probably means there's a bug with the
        # way we've configured GitHub. Our strategy will
        # be to display error messages to make future
        # debugging easier.
        flash[:error] = "Could not create new user account: #{user.errors.messages}"
        return redirect_to root_path
      end
    end
    
    # If we get here, we have a valid user instance
    session[:user_id] = user.id
    return redirect_to root_path
  end
  
  def edit; end
  
  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      return
    else
      render user_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out!"
    
    redirect_to root_path
  end
  
  private
  
  def user_params
    return params.require(:user).permit(:id, :name, :join_date, :uid, :provider, :email)
  end
  
  def find_user
    @user = User.find_by(id: params[:id])
  end
  
  def user_not_found
    if @user.nil?
      flash[:error] = "User with ID: #{params[:id]} was not found."
      redirect_to root_path
      return
    end
  end
  
  
  
end
