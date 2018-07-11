class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy

  def self.ordered_by_name
    order(:name)
  end
end
