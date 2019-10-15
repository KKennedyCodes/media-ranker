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
