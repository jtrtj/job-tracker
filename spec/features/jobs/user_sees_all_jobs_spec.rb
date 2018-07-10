require 'rails_helper'

describe "User sees all jobs" do
  scenario 'a user sees jobs index' do
    company = Company.create!(name: "ESPN")
    category = Category.create!(name: 'sdgfd')
    company.jobs.create!(title: "Developer", description: 'sagf', level_of_interest: 70, city: "Denver", category_id: category.id)
    company.jobs.create!(title: "QA Analyst", description: 'sdgfsa', level_of_interest: 70, city: "New York City", category_id: category.id)

    visit jobs_path

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("QA Analyst")
  end
  scenario "a user sees all the jobs for a specific company" do
    company = Company.create!(name: "ESPN")
    category = Category.create!(name: 'sdgfd')
    company.jobs.create!(title: "Developer", description: 'sagf', level_of_interest: 70, city: "Denver", category_id: category.id)
    company.jobs.create!(title: "QA Analyst", description: 'sdgfsa', level_of_interest: 70, city: "New York City", category_id: category.id)

    visit company_path(company)

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("QA Analyst")
  end

  scenario 'a user sees create job button' do
    visit jobs_path

    within(".hero") do
      click_on 'New Job'
    end

    expect(current_path).to eq(new_job_path)
  end
end
