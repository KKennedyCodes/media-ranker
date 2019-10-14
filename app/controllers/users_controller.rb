class UsersController < ApplicationController
  def index
  end
  
  def show
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
