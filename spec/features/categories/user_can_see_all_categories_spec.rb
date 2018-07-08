require 'rails_helper'

describe "User sees all categories" do
  scenario "a user sees all the categories" do
    category = Category.create!(name: "Development")
    category2 = Category.create!(name: "Finance")

    visit categories_path

    expect(page).to have_content(category.name)
    expect(page).to have_content(category2.name)
  end

end
