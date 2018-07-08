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
      it {should have_many(:jobs).through(:job_categories)}
    end
  end
end
