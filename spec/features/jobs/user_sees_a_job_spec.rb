require 'rails_helper'

describe 'User sees a specific job' do
  scenario 'a user sees a job for a specific company' do
    company = Company.create!(name: 'ESPN')
    category = Category.create!(name: 'sdgfd')
    job = company.jobs.create!(title: 'Developer',
                               description: 'sgfafg',
                               level_of_interest: 70,
                               city: 'Denver',
                               category_id: category.id)

    visit job_path(job)

    expect(page).to have_content(company.name)
    expect(page).to have_content(category.name)
    expect(page).to have_content(job.title)
    expect(page).to have_content(job.description)
    expect(page).to have_content(job.level_of_interest)
    expect(page).to have_content(job.city)
  end
end
