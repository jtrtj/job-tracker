require 'rails_helper'

describe 'user delete a job' do
  it 'can delete a job' do
    company1 = Company.create!(name: 'ESPN')
    category1 = Category.create!(name: 'Development')
    company2 = Company.create!(name: 'EA')
    category2 = Category.create!(name: 'Government')
    job1 = category1.jobs.create(title: 'King',
                                 description: 'Ruler',
                                 company_id: company1.id,
                                 level_of_interest: 80,
                                 city: 'London')
    job2 = category2.jobs.create(title: 'Jester',
                                 description: 'Flunkie',
                                 company_id: company2.id,
                                 level_of_interest: 40,
                                 city: 'Mumbai')

    visit jobs_path
    within "#job-#{job2.id}" do
      click_button 'Delete'
    end

    expect(current_path).to eq(jobs_path)
    expect(page).to_not have_content(company2.name)
    expect(page).to_not have_content(category2.name)
    expect(page).to have_content("#{job2.title} was successfully deleted!")

    expect(page).to have_content(company1.name)
    expect(page).to have_content(category1.name)
    expect(page).to have_content(job1.title)
  end
end
