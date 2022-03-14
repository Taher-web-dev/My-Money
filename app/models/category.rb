class Category < ApplicationRecord
  belongs_to :user
  has_many :operation_types
  has_many :expenses, through: :operation_types
  validates :name, presence: true
  validates :icon, presence: true
end
