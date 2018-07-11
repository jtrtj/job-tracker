require 'rails_helper'

describe 'User creates a new category' do
  scenario 'a user can create a new category' do
    visit new_category_path

    fill_in 'category[name]', with: 'Development'
    click_button 'Create'

    expect(current_path).to eq(category_path(Category.last.id))
    expect(page).to have_content(Category.last.name)
    expect(Category.count).to eq(1)
  end
  scenario 'a user cannot create a duplicate category' do
    category_name = 'Development'
    Category.create(name: category_name)

    visit new_category_path

    fill_in 'category[name]', with: category_name
    click_button 'Create'

    expect(current_path).to eq(new_category_path)
    expect(page).to have_content('Sorry')
    expect(Category.count).to eq(1)
  end
end
