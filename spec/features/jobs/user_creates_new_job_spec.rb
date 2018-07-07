require 'rails_helper'

describe "User creates a new job" do
  scenario "a user can create a new job" do
    company = Company.create!(name: "ESPN")
    visit jobs_path
    click_button 'New Job'

    fill_in "job[title]", with: "Developer"
    select company.name, from: "job[company_id]"
    # fill_in "job[company]", with: company.name
    fill_in "job[description]", with: "So fun!"
    select 5, from: "job[level_of_interest]"
    # fill_in "job[level_of_interest]", with: 80
    fill_in "job[city]", with: "Denver"

    click_button "Create"
    save_and_open_page
    expect(current_path).to eq("/jobs/#{Job.last.id}")
    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("5")
    expect(page).to have_content("Denver")
  end
end
