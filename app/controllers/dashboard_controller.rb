class DashboardController <ApplicationController
  def index
    @jobs_by_level_of_interest = Job.number_of_jobs_per_level_of_interest
    @jobs_by_location = Job.number_of_jobs_by_city
    @average_level_of_interest_by_company = Company.average_level_of_interest_by_company
  end
end