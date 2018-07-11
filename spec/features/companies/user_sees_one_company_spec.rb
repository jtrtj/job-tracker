require 'rails_helper'

describe 'User sees one company' do
  scenario 'a user sees a company' do
    company = Company.create!(name: 'ESPN')
    category = Category.create!(name: 'awesome!')
    company.jobs.create!(title: 'Developer',
                         description: 'sgfafg',
                         level_of_interest: 70,
                         city: 'Denver',
                         category_id: category.id)

    visit company_path(company)

    expect(current_path).to eq(company_path(company))
    expect(page).to have_content(company.name)
    expect(page).to have_content(company.jobs.first.title)
  end
end
