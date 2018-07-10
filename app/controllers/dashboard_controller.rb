class DashboardController <ApplicationController
  def index
    @jobs_by_level_of_interest = Job.number_of_jobs_per_level_of_interest
    @jobs_by_location = Job.number_of_jobs_by_city
  end
end