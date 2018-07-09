class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new()
    @categories = Category.ordered_by_name
    @companies = Company.all
  end

  def create
    category = Category.find(params[:job][:categories])
    @job = category.jobs.create(job_params)
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
    category = Category.find(params[:job][:categories])
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
    # implement on your own!
  end

  private

  def job_params
    params.require(:job).permit(:title,:company_id, :description, :level_of_interest, :city)
  end
end
