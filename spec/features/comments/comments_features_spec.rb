require 'spec_helper'

describe 'a user' do
  # let(:john)    { Company.create(name: 'John')}
  # let(:job)     { Job.create(
  #                           title: 'Personal assistant', 
  #                           description: 'servitude', 
  #                           level_of_interest: 5,
  #                           company_id: john.id,
  #                           city: 'Ghent'
  #                           )}
  # let(:comment_1)     {job.comments.create(content: 'wow cool')}
  # let(:comment_2)     {job.comments.create(content: 'wow really cool')}
  context 'visiting /jobs/show' do
    it "sees job's comments" do
      john = Company.create(name: 'John')
      job = Job.create(
                      title: 'Personal assistant', 
                      description: 'servitude', 
                      level_of_interest: 5,
                      company_id: john.id,
                      city: 'Ghent'
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

    it 'can make a comment' do
      john = Company.create(name: 'John')
      job = Job.create(
                      title: 'Personal assistant', 
                      description: 'servitude', 
                      level_of_interest: 5,
                      company_id: john.id,
                      city: 'Ghent'
                      )
      comment = job.comments.create(content: 'I dunno sounds hard')

      visit job_path(job)

      fill_in 'Comment', with: 'I dunno sounds hard'
      click_button 'Post'
      
      expect(current_path).to eq(job_path(job))
      expect(page).to have_content(comment.content)
    end

    it 'sees comments in descending chronological order' do
      john = Company.create(name: 'John')
      job = Job.create(
                      title: 'Personal assistant', 
                      description: 'servitude', 
                      level_of_interest: 5,
                      company_id: john.id,
                      city: 'Ghent'
                      )
      comment_1 = job.comments.create(content: 'I dunno sounds hard')
      comment_2 = job.comments.create(content: 'Maybe it wouldnt be')
      comment_3 = job.comments.create(content: 'I dunno its probably hard')

      visit job_path(job)

      comment_3.content.appears_before(comment_2.content)
      comment_2.content.appears_before(comment_1.content)
    end
  end
end