require 'rails_helper'

describe 'user' do
  it 'can delete a category' do
    category1 = Category.create!(name: 'Development')
    category2 = Category.create!(name: 'Finance')

    visit categories_path
    within "#category-#{category1.id}" do
      click_button('Delete')
    end

    expect(current_path).to eq(categories_path)
    within '#category-list' do
      expect(page).to_not have_content(category1.name)
      expect(page).to have_content(category2.name)
    end
  end
end
