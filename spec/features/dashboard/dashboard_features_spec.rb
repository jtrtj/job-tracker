require 'rails_helper'

describe 'user' do
  context 'visiting /dashboard' do
    it 'sees a count of jobs by level_of_interest' do
      company = Company.create!(name: "ESPN")
      category = Category.create!(name: 'sdgfd')
      job_1 = company.jobs.create!(title: "Developer", description: 'sagf', level_of_interest: 3, city: "Denver", category_id: category.id)
      job_2 = company.jobs.create!(title: "CEO", description: 'dfg', level_of_interest: 3, city: "Denver", category_id: category.id)
      job_3 = company.jobs.create!(title: "QA Analyst", description: 'sdgfsa', level_of_interest: 5, city: "New York City", category_id: category.id)

      visit dashboard_index_path
      save_and_open_page

      expect(page).to have_content("2 with interest level 3")
      expect(page).to have_content("1 with interest level 5")
    end

    it 'sees the top 3 companies ranked by level_of_interest wit their average_level_of_interest' do
      company_1 = Company.create!(name: "ESPN")
      company_2 = Company.create!(name: "COOL")
      category = Category.create!(name: 'sdgfd')
      job_1 = company_1.jobs.create!(title: "Developer", description: 'sagf', level_of_interest: 1, city: "Denver", category_id: category.id)
      job_2 = company_1.jobs.create!(title: "CEO", description: 'dfg', level_of_interest: 3, city: "Denver", category_id: category.id)
      job_3 = company_2.jobs.create!(title: "QA Analyst", description: 'sdgfsa', level_of_interest: 2, city: "New York City", category_id: category.id)
      job_3 = company_2.jobs.create!(title: "Acctuary", description: 'sdgfsa', level_of_interest: 4, city: "New York City", category_id: category.id)

      visit dashboard_index_path

      expect(page).to have_content("ESPN Average Interest: 2")
      expect(page).to have_content("COOL Average Interest: 3")
      expect(company_2.name).to appear_before(company_1.name)
    end

    it "sees a count of jobs by location with link to each location's jobs"  do
      company_1 = Company.create!(name: "ESPN")
      company_2 = Company.create!(name: "COOL")
      category = Category.create!(name: 'sdgfd')
      job_1 = company_1.jobs.create!(title: "Developer", description: 'sagf', level_of_interest: 1, city: "Denver", category_id: category.id)
      job_2 = company_1.jobs.create!(title: "CEO", description: 'dfg', level_of_interest: 3, city: "Denver", category_id: category.id)
      job_3 = company_2.jobs.create!(title: "QA Analyst", description: 'sdgfsa', level_of_interest: 2, city: "New York City", category_id: category.id)
      
      visit dashboard_index_path

      expect(page).to have_content("2 located in Denver")
      expect(page).to have_content("1 located in New York City")

      click_on "Denver"
      
      expect(current_path).to eq("/jobs/?location=Denver")
      expect(page).to have_content("job_1.title")
      expect(page).to have_content("job_2.title")
    end
  end
end