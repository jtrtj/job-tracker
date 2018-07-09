require 'rails_helper'

describe 'user' do
  it 'can update a category' do
    category = Category.create!(name: "Development")
    category2 = Category.create!(name: "Finance")

    visit categories_path
    within "#category-#{category.id}" do
      click_button('Edit')
    end

    expect(current_path).to eq("/categories/#{category.id}/edit")

    fill_in 'Name', with: 'DevOps'
    click_button 'Update'

    expect(current_path).to eq("/categories/#{category.id}")
    expect(page).to have_content('DevOps')
    expect(page).to_not have_content('Development')
  end
end
