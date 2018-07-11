require 'rails_helper'

describe 'user' do
  it 'can update a category' do
    category = Category.create!(name: 'Development')
    new_name = 'DevOps'

    visit categories_path
    within "#category-#{category.id}" do
      click_button('Edit')
    end

    expect(current_path).to eq(edit_category_path(category))

    fill_in 'Name', with: new_name
    click_button 'Update'

    expect(current_path).to eq(category_path(category))
    expect(page).to have_content(new_name)
    expect(page).to_not have_content(category.name)
  end
end
