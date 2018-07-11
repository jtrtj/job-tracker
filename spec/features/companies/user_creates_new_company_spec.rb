require 'rails_helper'

describe 'User creates a new company' do
  scenario 'a user can create a new company' do
    new_company = 'ESPN'
    visit new_company_path

    fill_in 'company[name]', with: 'ESPN'
    click_button 'Create'

    expect(current_path).to eq(company_path(Company.last.id))
    expect(page).to have_content(new_company)
    expect(Company.count).to eq(1)
  end
end
