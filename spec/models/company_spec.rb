require 'rails_helper'

describe Company do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  it 'has a unique name' do
    Company.create(name: 'Dropbox')
    company = Company.new(name: 'Dropbox')
    expect(company).to be_invalid
  end

  describe 'relationships' do
    it 'has many jobs' do
      company = Company.new(name: 'Dropbox')
      expect(company).to respond_to(:jobs)
    end
  end

  describe 'class methods' do
    it '#average_level_of_interest_by_company' do
      company1 = Company.create!(name: 'ESPN')
      company2 = Company.create!(name: 'COOL')
      category = Category.create!(name: 'sdgfd')
      job1 = company1.jobs.create!(title: 'Developer',
                                   description: 'sagf',
                                   level_of_interest: 1,
                                   city: 'Denver',
                                   category_id: category.id)
      job2 = company1.jobs.create!(title: 'CEO',
                                   description: 'dfg',
                                   level_of_interest: 3,
                                   city: 'Denver',
                                   category_id: category.id)
      job3 = company2.jobs.create!(title: 'QA Analyst',
                                   description: 'sdgfsa',
                                   level_of_interest: 2,
                                   city: 'New York City',
                                   category_id: category.id)
      job4 = company2.jobs.create!(title: 'Acctuary',
                                   description: 'sdgfsa',
                                   level_of_interest: 4,
                                   city: 'New York City',
                                   category_id: category.id)

      expect(Company.average_level_of_interest_by_company).to eq([company2,
                                                                  company1])
    end

    it '#sort_by_name' do
      company1 = Company.create!(name: 'ESPN')
      company2 = Company.create!(name: 'COOL')

      expext(Company.sort_by_name).to eq([company2, company1])
    end
  end
end
