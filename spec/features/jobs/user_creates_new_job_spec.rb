require 'rails_helper'

describe 'User creates a new job' do
  scenario 'a user can create a new job' do
    company = Company.create!(name: 'ESPN')
    category = Category.create!(name: 'Development')
    job_title = 'Developer'
    job_description = 'So fun!'
    job_level_of_interest = 5
    job_city = 'Denver'

    visit jobs_path
    click_button 'New Job'

    select category.name, from: :job_category_id
    fill_in :job_title, with: job_title
    select company.name, from: :job_company_id
    fill_in :job_description, with: job_description
    select job_level_of_interest, from: :job_level_of_interest
    fill_in :job_city, with: job_city

    click_button 'Save'

    expect(current_path).to eq(job_path(Job.last.id))
    expect(page).to have_content(company.name)
    expect(page).to have_content(job_title)
    expect(page).to have_content(job_description)
    expect(page).to have_content(category.name)
    expect(page).to have_content(job_level_of_interest)
    expect(page).to have_content(job_city)
  end
end
