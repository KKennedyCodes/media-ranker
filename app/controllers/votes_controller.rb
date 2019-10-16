class VotesController < ApplicationController
  
  before_action :find_vote, only: [:show, :edit, :update]
  before_action :vote_not_found, only: [:show, :edit, :destroy]
  
  def index
    @votes = Vote.all
  end
  
  def show; end
  
  def new
    @vote = Vote.new
  end
  
  def create
    @vote = Vote.new(vote_params)
    if vote.save
      redirect_to votes_path
      return
    else
      render :new
    end
  end
  
  def edit; end
  
  def update
    if @vote.update(vote_params)
      redirect_to vote_path(@vote.id)
    end
    
    def destroy
      @vote.destroy
      redirect_to votes_path
    end
    
    private
    
    def vote_params
      return params.require(:vote).permit(:id, :work_id, :user_id, :date)
    end
    
    def find_vote
      @vote = Vote.find_by(id: params[:id])
    end
    
    def vote_not_found
      if @vote.nil?
        flash[:error] = "Vote with ID: #{params[:id]} was not found."
        redirect_to root_path
        return
      end
    end
  end
  