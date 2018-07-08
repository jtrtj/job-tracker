require 'rails_helper'

describe 'a user' do
  context 'visiting company/show' do
    it 'sees a company contact form' do
      taco_bell = Company.create!(name: 'Taco Bell')

      visit company_path(taco_bell)

      fill_in 'Name', with: 'Suzan Surandon'
      fill_in 'Role', with: 'Manager'
      fill_in 'Email', with: 'suzan@tbhq.org'
      click_button 'Save'

      expect(current_path).to eq(company_path(taco_bell))
      expect(page).to have_content('Suzan Surandon')
      expect(page).to have_content('Manager')
      expect(page).to have_content('suzan@tbhq.org')
    end
  end
end
