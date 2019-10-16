class WorksController < ApplicationController
  
  before_action :find_work, only: [:show, :edit, :update]
  before_action :work_not_found, only: [:show, :edit, :destroy]
  
  def index
    @works = Work.all
    @albums = @works.where(category: "album")
    @books = @works.where(category: "book")
    @movies = @works.where(category: "movie")
  end
  
  def show;  end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(work_params)
    if @work.save
      if @work.category == "album"
        @albums << @work
      elsif @work.category == "book"
        @books << @work
      else
        @movies << @work
      end
      redirect_to works_path
      return 
    else 
      render :new
    end
  end
  
  def edit; end
  
  def update
    if @work.update(work_params)
      redirect_to work_path(@work.id)
      return
    else
      render work_path
    end
  end
  
  def destroy    
    @work.destroy
    redirect_to works_path
    return
  end
  
  def self.top_ten
    @albums.sort_by!(&:votes)
    @books.sort_by!(&:votes)
    @movies.sort_by!(&:votes)
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:id, :category, :title, :creator, :publication_year, :description)
  end
  
  def find_work
    @work = Work.find_by(id: params[:id])
  end
  
  def work_not_found
    if @work.nil?
      flash[:error] = "Work with ID: #{params[:id]} was not found."
      redirect_to root_path
      return
    end
  end
end
