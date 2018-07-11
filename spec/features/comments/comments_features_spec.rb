require 'spec_helper'

describe 'a user' do
  context 'visiting /jobs/show' do
    it "sees job's comments" do
      john = Company.create(name: 'John')
      category = Category.create!(name: 'awesome!')
      job = Job.create(title: 'Personal assistant',
                       description: 'servitude',
                       level_of_interest: 5,
                       company_id: john.id,
                       city: 'Ghent',
                       category_id: category.id)
      comment1 = job.comments.create(content: 'wow cool')
      comment2 = job.comments.create(content: 'wow really cool')

      visit job_path(job)

      expect(page).to have_content(comment1.content)
      expect(page).to have_content(comment2.content)
      expect(page).to have_content(comment1.created_at)
      expect(page).to have_content(comment2.created_at)
      expect(page).to have_content(comment1.updated_at)
      expect(page).to have_content(comment2.updated_at)
    end

    it 'can make a comment and is redirected to jobs/show' do
      john = Company.create(name: 'John')
      category = Category.create!(name: 'awesomer!')
      job = Job.create(title: 'Personal assistant',
                       description: 'servitude',
                       level_of_interest: 5,
                       company_id: john.id,
                       city: 'Ghent',
                       category_id: category.id)
      comment = job.comments.create(content: 'I dunno sounds hard')

      visit job_path(job)

      fill_in 'Note', with: 'I dunno sounds hard'
      click_button 'Save'

      expect(current_path).to eq(job_path(job))
      expect(page).to have_content(comment.content)
    end

    it 'sees comments in descending chronological order' do
      john = Company.create(name: 'John')
      category = Category.create!(name: 'awesomest!')
      job = Job.create(title: 'Personal assistant',
                       description: 'servitude',
                       level_of_interest: 5,
                       company_id: john.id,
                       city: 'Ghent',
                       category_id: category.id)
      comment1 = job.comments.create(content: 'I dunno sounds hard',
                                     created_at: '2018-07-08 21:40:46 UTC')
      comment2 = job.comments.create(content: 'Maybe it wouldnt be',
                                     created_at: '2018-07-08 21:40:48 UTC')
      comment3 = job.comments.create(content: 'I dunno its probably hard',
                                     created_at: '2018-07-08 21:40:50 UTC')

      visit job_path(job)

      expect(comment3.content).to appear_before(comment2.content)
      expect(comment2.content).to appear_before(comment1.content)
      expect(comment1.content).to_not appear_before(comment2.content)
      expect(comment2.content).to_not appear_before(comment3.content)
    end
  end
end
