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
  
  def edit
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to user_path
      head :not_found
      return
    end
  end
  
  def update
    #Handle Validation Errors
    @user = User.find_by(id: params[:id])
    if @user.nil? 
      head :not_found
      return
      #anytime we do a head or render or redirect
    end
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      return
    else
      render user_path
    end
  end
  
  def destroy
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    
    if @user.nil?
      head :not_found
      return
    end
    
    @user.destroy
    
    redirect_to users_path
    return
  end
  
  private
  
  def user_params
    return params.require(:user).permit(:id, :name, :join_date)
  end
  
end
