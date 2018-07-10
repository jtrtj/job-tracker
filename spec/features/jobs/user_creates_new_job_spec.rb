require 'rails_helper'

describe "User creates a new job" do
  scenario "a user can create a new job" do
    company = Company.create!(name: "ESPN")
    category = Category.create!(name: "Development")

    visit jobs_path
    click_button 'New Job'

    select category.name, from: :job_category_id
    fill_in :job_title, with: "Developer"
    select company.name, from: :job_company_id
    fill_in :job_description, with: "So fun!"
    select 5, from: :job_level_of_interest
    fill_in :job_city, with: "Denver"

    click_button "Save"

    expect(current_path).to eq("/jobs/#{Job.last.id}")
    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("Development")
    expect(page).to have_content("5")
    expect(page).to have_content("Denver")
  end
end
