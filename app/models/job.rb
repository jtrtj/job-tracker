class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, :description, :company_id, presence: true
  belongs_to :company
  has_many :job_categories
  has_many :categories, through: :job_categories
end
