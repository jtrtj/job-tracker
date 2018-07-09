require 'rails_helper'

describe Job do
  describe "validations" do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:level_of_interest)}
    it {should validate_presence_of(:company_id)}
    it {should validate_presence_of(:city)}
  end

  describe "relationships" do
    it "belongs to a company" do
      job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo")
      expect(job).to respond_to(:company)
    end
    context "has many categories through job_categories" do
      it {should belong_to(:category)}
    end
  end
end
