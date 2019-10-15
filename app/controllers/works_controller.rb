class WorksController < ApplicationController
  def index
    @works = Work.all
  end
  
  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
      head :not_found
      return
    end
  end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to works_path
      return 
    else 
      render :new
    end
  end
  
  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to work_path
      head :not_found
      return
    end
  end
  
  def update
    #Handle Validation Errors
    @work = Work.find_by(id: params[:id])
    if @work.nil? 
      head :not_found
      return
      #anytime we do a head or render or redirect
    end
    if @work.update(work_params)
      redirect_to work_path(@work.id)
      return
    else
      render work_path
    end
  end
  
  def destroy
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.nil?
      head :not_found
      return
    end
    
    @work.destroy
    
    redirect_to works_path
    return
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:id, :category, :title, :creator, :publication_year, :description)
  end
end
