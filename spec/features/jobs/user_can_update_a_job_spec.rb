require 'rails_helper'

describe 'user edits a job' do
  it 'can update a job' do
    company1 = Company.create!(name: "ESPN")
    category1 = Category.create!(name: "Development")
    company2 = Company.create!(name: "EA")
    category2 = Category.create!(name: "Government")
    job = category1.jobs.create(title: "King",
                               description: "Ruler",
                               company_id: company1.id,
                               level_of_interest: 80,
                               city: 'London')

    visit job_path(job)
    click_button 'Edit'

    select category2.name, from: 'job[categories]'
    fill_in "job[title]", with: "Jester"
    select company2.name, from: "job[company_id]"
    fill_in "job[description]", with: "Flunkie"
    select 2, from: "job[level_of_interest]"
    fill_in "job[city]", with: "Mumbai"

    click_button 'Save'

    expect(current_path).to eq(job_path(job))
    expect(page).to have_content('EA')
    expect(page).to have_content('Jester')
    expect(page).to have_content('Flunkie')
    expect(page).to have_content('Government')
    expect(page).to have_content(2)
    expect(page).to have_content('Mumbai')
  end
end
