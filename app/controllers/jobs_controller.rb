class JobsController < ApplicationController
  def index
    if params[:sort] == 'location'
      @jobs = Job.all.order(city: :asc)
    elsif params[:sort] == 'interest'
      @jobs = Job.all.order(level_of_interest: :desc)
    elsif params[:location]
      @jobs = Job.where(city: params[:location])
      render :city
    else
      @jobs = Job.all
    end
  end

  def new
    @job = Job.new()
    @categories = Category.ordered_by_name
    @companies = Company.all
  end

  def create
    @job = Job.create(job_params)
    if @job.save
      flash.notice = "#{@job.title} at #{@job.company} Created!"
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
    @comment = Comment.new
    @comment.job_id = @job.id
  end

  def edit
    @job = Job.find(params[:id])
    @categories = Category.ordered_by_name
    @companies = Company.all
  end

  def update
    @job = Job.find(params[:id])
    @job.update(job_params)
    if @job.save
      flash[:success] = "#{@job.title} updated!"
      redirect_to job_path(@job)
    else
      render :edit
    end
  end

  def destroy
    job = Job.find(params[:id])
    job.destroy

    flash[:success] = "#{job.title} was successfully deleted!"
    redirect_to jobs_path
  end

  private

  def job_params
    params.require(:job).permit(:title,:company_id, :description, :level_of_interest, :city, :category_id)
  end
end
