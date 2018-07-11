require 'rails_helper'

describe Company do
  describe "validations" do
    it {should validate_presence_of(:name)}
  end

  it "has a unique name" do
    Company.create(name: "Dropbox")
    company = Company.new(name: "Dropbox")
    expect(company).to be_invalid
  end

  describe "relationships" do
    it "has many jobs" do
      company = Company.new(name: "Dropbox")
      expect(company).to respond_to(:jobs)
    end
  end

  describe 'class methods' do
    it '#average_level_of_interest_by_company' do
      company_1 = Company.create!(name: "ESPN")
      company_2 = Company.create!(name: "COOL")
      category = Category.create!(name: 'sdgfd')
      job_1 = company_1.jobs.create!(title: "Developer", description: 'sagf', level_of_interest: 1, city: "Denver", category_id: category.id)
      job_2 = company_1.jobs.create!(title: "CEO", description: 'dfg', level_of_interest: 3, city: "Denver", category_id: category.id)
      job_3 = company_2.jobs.create!(title: "QA Analyst", description: 'sdgfsa', level_of_interest: 2, city: "New York City", category_id: category.id)
      job_3 = company_2.jobs.create!(title: "Acctuary", description: 'sdgfsa', level_of_interest: 4, city: "New York City", category_id: category.id)

      expect(Company.average_level_of_interest_by_company).to eq([company_2, company_1])
    end
  end
end
