require 'rails_helper'

describe 'user' do
  context 'visiting /dashboard' do
    it 'sees a count of jobs by level_of_interest' do
      company = Company.create!(name: 'ESPN')
      category = Category.create!(name: 'sdgfd')
      job1 = company.jobs.create!(title: 'Developer',
                                  description: 'sagf',
                                  level_of_interest: 3,
                                  city: 'Denver',
                                  category_id: category.id)
      job2 = company.jobs.create!(title: 'CEO',
                                  description: 'dfg',
                                  level_of_interest: 3,
                                  city: 'Denver',
                                  category_id: category.id)
      job3 = company.jobs.create!(title: 'QA Analyst',
                                  description: 'sdgfsa',
                                  level_of_interest: 5,
                                  city: 'New York City',
                                  category_id: category.id)
      level3 = Job.number_of_jobs_per_level_of_interest[3]
      level5 = Job.number_of_jobs_per_level_of_interest[5]

      visit dashboard_index_path

      expect(page).to have_content("#{level3} with interest level 3")
      expect(page).to have_content("#{level5} with interest level 5")
    end

    it 'sees the top 3 companies ranked by and with average level_of_interest' do
      company1 = Company.create!(name: 'ESPN')
      company2 = Company.create!(name: 'COOL')
      company3 = Company.create!(name: 'Sad')
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
      job5 = company3.jobs.create!(title: 'Acctuary',
                                   description: 'sdgfsa',
                                   level_of_interest: 1,
                                   city: 'New York City',
                                   category_id: category.id)
      cool = Company.average_level_of_interest_by_company[0]
      espn = Company.average_level_of_interest_by_company[1]
      visit dashboard_index_path

      expect(page).to have_content("#{espn.name} has interest level of 2")
      expect(page).to have_content("#{cool.name} has interest level of 3")
      expect(company2.name).to appear_before(company1.name)
    end

    it "sees a count of jobs by location with link to each location's jobs"  do
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
      denver = Job.number_of_jobs_by_city.key(0)
      new_york = Job.number_of_jobs_by_city.key(1)

      visit dashboard_index_path

      expect(page).to have_content("2 located in #{denver}")
      expect(page).to have_content("1 located in #{new_york}")

      click_on 'Denver'

      expect(current_path).to eq(jobs_path)
      expect(page).to have_content(job1.title)
      expect(page).to have_content(job2.title)
      expect(page).to_not have_content(job3.title)
    end
  end
end
