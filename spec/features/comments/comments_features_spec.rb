require 'spec_helper'

describe 'a user' do
  context 'visiting /jobs/show' do
    it "sees job's comments" do
      john = Company.create(name: 'John')
      category = Category.create!(name: 'awesome!')
      job = Job.create(
                      title: 'Personal assistant',
                      description: 'servitude',
                      level_of_interest: 5,
                      company_id: john.id,
                      city: 'Ghent',
                      category_id: category.id
                      )
      comment_1 = job.comments.create(content: 'wow cool')
      comment_2 = job.comments.create(content: 'wow really cool')

      visit job_path(job)

      expect(page).to have_content(comment_1.content)
      expect(page).to have_content(comment_2.content)
      expect(page).to have_content(comment_1.created_at)
      expect(page).to have_content(comment_2.created_at)
      expect(page).to have_content(comment_1.updated_at)
      expect(page).to have_content(comment_2.updated_at)
    end

    it 'can make a comment and is redirected to jobs/show' do
      john = Company.create(name: 'John')
      category = Category.create!(name: 'awesomer!')
      job = Job.create(
                      title: 'Personal assistant',
                      description: 'servitude',
                      level_of_interest: 5,
                      company_id: john.id,
                      city: 'Ghent',
                      category_id: category.id
                      )
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
      job = Job.create(
                      title: 'Personal assistant',
                      description: 'servitude',
                      level_of_interest: 5,
                      company_id: john.id,
                      city: 'Ghent',
                      category_id: category.id
                      )
      comment_1 = job.comments.create(content: 'I dunno sounds hard', created_at: "2018-07-08 21:40:46 UTC")
      comment_2 = job.comments.create(content: 'Maybe it wouldnt be', created_at: "2018-07-08 21:40:48 UTC")
      comment_3 = job.comments.create(content: 'I dunno its probably hard', created_at: "2018-07-08 21:40:50 UTC")

      visit job_path(job)

      expect(comment_3.content).to appear_before(comment_2.content)
      expect(comment_2.content).to appear_before(comment_1.content)
      expect(comment_1.content).to_not appear_before(comment_2.content)
      expect(comment_2.content).to_not appear_before(comment_3.content)
    end
  end
end
