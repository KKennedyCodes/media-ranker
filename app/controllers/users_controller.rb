class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    if @user.nil?
      head :not_found
      return
    end
  end
  
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
      flash[:success] = "Successfully logged in as new user #{name}"
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
    flash[:success] = "Successfully Logged Out"
    
    redirect_to root_path
  end
  
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def user_params
    return params.require(:user).permit(:id, :name, :join_date)
  end
  
end
