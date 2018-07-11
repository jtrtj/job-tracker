require 'rails_helper'

describe 'user edits a job' do
  it 'can update a job' do
    company1 = Company.create!(name: 'ESPN')
    category1 = Category.create!(name: 'Development')
    company2 = Company.create!(name: 'EA')
    category2 = Category.create!(name: 'Government')
    job = category1.jobs.create(title: 'King',
                                description: 'Ruler',
                                company_id: company1.id,
                                level_of_interest: 80,
                                city: 'London')
    new_title = 'Jester'
    new_description = 'Flunkie'
    new_level_of_interest = 2
    new_city = 'Mumbai'

    visit job_path(job)
    click_button 'Edit'

    select category2.name, from: :job_category_id
    fill_in :job_title, with: new_title
    select company2.name, from: :job_company_id
    fill_in :job_description, with: new_description
    select new_level_of_interest, from: :job_level_of_interest
    fill_in :job_city, with: new_city

    click_button 'Save'

    expect(current_path).to eq(job_path(job))
    expect(page).to have_content(company2.name)
    expect(page).to have_content(new_title)
    expect(page).to have_content(new_description)
    expect(page).to have_content(category2.name)
    expect(page).to have_content(new_level_of_interest)
    expect(page).to have_content(new_city)
  end
end
