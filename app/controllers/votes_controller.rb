class VotesController < ApplicationController
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
  
  def vote_params
    return params.require(:vote).permit(:id, :work_id, :user_id, :date)
  end
end
