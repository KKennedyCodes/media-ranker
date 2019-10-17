class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :user_not_found, only: [:show, :edit, :destroy]
  
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
    flash[:success] = "Successfully Logged Out"
    
    redirect_to root_path
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
      return 
    else 
      render :new
    end
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
    @user.destroy
    redirect_to users_path
    return
  end
  
  private
  
  def user_params
    return params.require(:user).permit(:id, :name, :join_date)
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
