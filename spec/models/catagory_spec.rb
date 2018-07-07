require 'rails_helper'

describe Category do
  describe "validations" do
    it {should validate_presence_of(:name)}
  end

  it "has a unique name" do
    Category.create(name: "Dropbox")
    category = Category.new(name: "Dropbox")
    expect(category).to be_invalid
  end

  describe "relationships" do
    it "has many jobs" do
      category = Category.new(name: "Dropbox")
      expect(category).to respond_to(:jobs)
    end
  end
end
