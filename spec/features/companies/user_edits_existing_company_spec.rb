require 'rails_helper'

describe 'User edits an existing company' do
  scenario 'a user can edit a company' do
    company = Company.create!(name: 'ESPN')
    new_name = 'EA Sports'
    visit edit_company_path(company)

    fill_in 'company[name]', with: new_name
    click_button 'Update'

    expect(current_path).to eq(company_path(company))
    expect(page).to have_content(new_name)
    expect(page).to_not have_content(company.name)
  end
end
