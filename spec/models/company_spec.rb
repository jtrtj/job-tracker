require 'rails_helper'

describe Company do
  describe "validations" do
    it {should validate_presence_of(:name)}
  end

  it "has a unique name" do
    Company.create(name: "Dropbox")
    company = Company.new(name: "Dropbox")
    expect(company).to be_invalid
  end

  describe "relationships" do
    it "has many jobs" do
      company = Company.new(name: "Dropbox")
      expect(company).to respond_to(:jobs)
    end
  end
end
