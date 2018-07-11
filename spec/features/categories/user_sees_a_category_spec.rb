require 'rails_helper'

describe 'a user' do
  context 'visiting /categories/show' do
    it 'should see a single category' do
      category = Category.create!(name: 'Development')

      visit categories_path(category)

      expect(page).to have_content(category.name)
    end
    it 'should see a categories associated jobs' do
      company = Company.create!(name: 'ESPN')
      category = Category.create!(name: 'sdgfd')
      job1 = company.jobs.create!(title: 'Developer',
                                  description: 'sagf',
                                  level_of_interest: 70,
                                  city: 'Denver',
                                  category_id: category.id)
      job2 = company.jobs.create!(title: 'QA Analyst',
                                  description: 'sdgfsa',
                                  level_of_interest: 70,
                                  city: 'New York City',
                                  category_id: category.id)

      visit category_path(category)

      expect(page).to have_content(category.name)
      expect(page).to have_content(job1.title)
      expect(page).to have_content(job2.title)
    end
  end
end
