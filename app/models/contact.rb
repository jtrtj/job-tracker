class Contact < ApplicationRecord
  validates :name, :role, :email, presence: true
  belongs_to :company
end