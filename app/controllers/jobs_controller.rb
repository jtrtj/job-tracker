class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new()
    @companies = Company.all
  end

  def create
    @job = Job.new(job_params)
    @categories = Categories.ordered_by_name
    if @job.save
      flash.notice = "#{@job.title} at #{@job.company} Created!"
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit
    # implement on your own!
  end

  def update
    # implement on your own!
  end

  def destroy
    # implement on your own!
  end

  private

  def job_params
    params.require(:job).permit(:title,:company_id, :description, :level_of_interest, :city)
  end
end
