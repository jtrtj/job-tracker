class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :contacts, dependent: :destroy

  def self.average_level_of_interest_by_company
    select("companies.*, avg(level_of_interest) AS average_level_of_interest")
    .joins(:jobs)
    .group(:company_id, :id)
    .order("average_level_of_interest DESC")
    .limit(3)
  end
end
