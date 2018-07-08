require 'rails_helper'

describe 'user' do
  it 'can delete a category' do
    category = Category.create!(name: "Development")
    category2 = Category.create!(name: "Finance")

    visit categories_path
    within "#category-#{category.id}" do
      click_button('Delete')
    end
    
    expect(current_path).to eq(categories_path)
    within "#category-list" do
     expect(page).to_not have_content(category.name)
    end
  end
end