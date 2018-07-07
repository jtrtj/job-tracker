class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new()
    @companies = Company.all
  end

  def create
    @company = Company.find(params[:job][:company_id])
    @job = @company.jobs.new(job_params)
    if @job.save
      flash.notice = "#{@job.title} at #{@company.name} Created!"
      # flash[:success] = "You created #{@job.title} at #{@company.name}"
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
    params.require(:job).permit(:title, :description, :level_of_interest, :city)
  end
end
