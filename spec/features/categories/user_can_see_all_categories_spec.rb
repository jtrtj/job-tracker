require 'rails_helper'

describe "User sees all categories" do
  scenario "a user sees all the categories" do
    category = Category.create!(name: "Development")
    category2 = Category.create!(name: "Finance")

    visit categories_path

    expect(page).to have_content(category.name)
    expect(page).to have_content(category2.name)
  end

  scenario 'a user sees a edit button' do
    category = Category.create!(name: "Development")

    visit categories_path
    within "#category-#{category.id}" do
      click_button('Edit')
    end

    expect(current_path).to eq("/categories/#{category.id}/edit")
  end
end
