class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end
  
  def show
    vote_id = params[:id]
    @vote = Vote.find_by(id: vote_id)
    if @vote.nil?
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
  
  def vote_params
    return params.require(:vote).permit(:id, :work_id, :user_id, :date)
  end
end
