require 'rails_helper'

describe Job do
  describe "validations" do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:level_of_interest)}
    it {should validate_presence_of(:company_id)}
    it {should validate_presence_of(:category_id)}
    it {should validate_presence_of(:city)}
  end

  describe "relationships" do
    it "belongs to a company" do
      job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo")
      expect(job).to respond_to(:company)
    end
    context "has many categories through job_categories" do
      it {should belong_to(:category)}
    end
  end 
  describe 'class methods' do
    it '#number_of_jobs_per_level_of_interest' do
      company = Company.create(name: 'sdfghf')
      category = Category.create(name: 'sdfgf')
      job_1 = company.jobs.create!(title: "Developer", description: 'sagf', level_of_interest: 1, city: "Denver", category_id: category.id)
      job_2 = company.jobs.create!(title: "CEO", description: 'dfg', level_of_interest: 3, city: "Denver", category_id: category.id)
      job_3 = company.jobs.create!(title: "QA Analyst", description: 'sdgfsa', level_of_interest: 2, city: "New York City", category_id: category.id)
      job_3 = company.jobs.create!(title: "Acctuary", description: 'sdgfsa', level_of_interest: 3, city: "New York City", category_id: category.id)

      expect(Job.number_of_jobs_per_level_of_interest).to eq({1 => 1, 2 => 1, 3 => 2})
    end
  end
end
