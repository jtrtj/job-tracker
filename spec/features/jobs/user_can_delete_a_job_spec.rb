require 'rails_helper'

describe 'user delete a job' do
  it 'can delete a job' do
    company1 = Company.create!(name: "ESPN")
    category1 = Category.create!(name: "Development")
    company2 = Company.create!(name: "EA")
    category2 = Category.create!(name: "Government")
    job = category1.jobs.create(title: "King",
                               description: "Ruler",
                               company_id: company1.id,
                               level_of_interest: 80,
                               city: 'London')

    visit jobs_path
    within "#job-#{job.id}" do
      click_button 'Delete'
    end

    expect(current_path).to eq(jobs_path)
    expect(page).to_not have_content('EA')
    expect(page).to_not have_content('Jester')
    expect(page).to_not have_content('Flunkie')
    expect(page).to_not have_content('Government')
    expect(page).to_not have_content(2)
    expect(page).to_not have_content('Mumbai')
  end
end
