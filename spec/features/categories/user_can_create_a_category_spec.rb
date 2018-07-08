require 'rails_helper'

describe "User creates a new category" do
  scenario "a user can create a new category" do
    visit new_category_path

    fill_in "category[name]", with: "Development"
    click_button "Create"

    expect(current_path).to eq("/categories/#{Category.last.id}")
    expect(page).to have_content("Development")
    expect(Category.count).to eq(1)
  end
  scenario "a user cannot create a duplicate category" do
    Category.create(name: 'Development')

    visit new_category_path

    fill_in "category[name]", with: "Development"
    click_button "Create"

    expect(current_path).to eq("/categories/new")
    expect(page).to have_content("Sorry")
    expect(Category.count).to eq(1)
  end
end
