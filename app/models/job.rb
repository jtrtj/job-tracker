class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, :description, :company_id, :category_id, presence: true
  belongs_to :company
  belongs_to :category
  has_many :comments, dependent: :destroy

  def self.number_of_jobs_per_level_of_interest
    order(level_of_interest: :DESC).group(:level_of_interest).count
  end

  def self.number_of_jobs_by_city
    group(:city).count
  end
end
