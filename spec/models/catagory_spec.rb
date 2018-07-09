require 'rails_helper'

describe Category do
  describe "validations" do
    it {should validate_presence_of(:name)}
  end

  it "has a unique name" do
    Category.create(name: "Development")
    category = Category.new(name: "Development")
    expect(category).to be_invalid
  end

  describe "relationships" do
    context "has many jobs through job_categories" do
      it {should have_many(:jobs)}
    end
  end

  describe 'class methods' do
    it '#ordered_by_name' do
      category_1 = Category.create(name: "A")
      category_2 = Category.create(name: "B")
      category_3 = Category.create(name: "C")

      expect(Category.ordered_by_name).to eq([category_1, category_2, category_3])
    end
  end
end
